class ComplaintsController < ApplicationController
  before_filter :authenticate_user!, :except => [ :index ]

  def index
    @complaints = Complaint.all
  end

  def new
    @complaint = Complaint.new
  end

  def create
    result = false

    begin
      repo = Storage::Repository.new
      ActiveRecord::Base.transaction do
        files = params[:complaint].delete(:files) || [] 
        @complaint = Complaint.new( params[:complaint] )
        @complaint.author = current_user

        files.each do |f|
          proof = Proof.create( :space => :dropbox, :path => f.original_filename )
          repo.upload( proof.path, f.tempfile )
          @complaint.attachs( proof )
        end

        result = @complaint.save 
      end
    rescue RepositoryError => e
      result = false 
    end

    if ( result )
      redirect_to complaints_path
    else
      render :new
    end

  end

  def edit
    @complaint = Complaint.find( params[:id] )

    if @complaint.nil?
      return head(:not_found) unless @complaint
    else
      return head(:forbidden) unless @complaint.written_by?( current_user )
    end

  end

  def update
    @complaint = Complaint.find(params[:id])

    if @complaint.nil?
      return head(:not_found) unless @complaint
    else
      return head(:forbidden) unless @complaint.written_by?( current_user )
    end
    
    if @complaint.update_attributes( params[:complaint] )
      redirect_to complaints_path
    else
      render :edit
    end
  end

  # TODO
  #
  # user_id should be current user forbidden
  # if complaint doesn't exist not_found
  #
  def advocated_by_user
    complaint = Complaint.find_by_id(params[:id])
    user = current_user
    
    return head(:bad_request) unless complaint and user

    user.advocates( complaint )

    render json: { :id => complaint.id,                         \
      :advocators => complaint.advocators.map { |u| u.email }   \
    }
  end
  
  def relinquished_by_user
    complaint = Complaint.find_by_id(params[:id])
    user = current_user
    
    return head(:bad_request) unless complaint and user

    user.relinquishes( complaint )

    render json: { :id => complaint.id,                         \
      :advocators => complaint.advocators.map { |u| u.email }   \
    }
  end
end

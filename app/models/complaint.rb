class Complaint < ActiveRecord::Base
  attr_accessible :body, :title, :author

  validates :title, :body, :presence => true
  validates :author, :presence => true

  has_many :signatures
  has_many :users, :through => :signatures

  before_save do
    unless @author.nil? 
      self.signatures.new( :when => Date.today, :user => @author ) unless @author.nil?
    end
  end

  def author=( user ) 
    @author = user if self.users.empty?
  end

  def author
    self.users.first || @author
  end

  def has_advocators?
    not self.advocators.empty?
  end

  def advocators
    self.users(true)[1..(self.users.count)] || [] # It skips author
  end

  def written_by?( user )
    author == user
  end

  def advocated_by( user )
    self.signatures.create!( :when => Date.today, :user => user)    \
      unless                                                        \
        user == self.author or self.advocators.include?( user )

  end

  def relinquished_by( user )
    self.users.delete( user ) unless self.author == user
  end

  def self.by_author( user )
    result = Complaint.joins(:users).where( 
      "signatures.user_id = #{user.id}")

    result.select! do |complaint|
      complaint.author == user
    end

    result
  end

  def self.top( how_many = 5 )
    Signature.select( 'complaint_id, count(user_id) as counter' ) \
      .group(:complaint_id)                                       \
      .order( 'counter desc')                                     \
      .last( how_many )                                           \
      .map { |s| s.complaint }
  end


end

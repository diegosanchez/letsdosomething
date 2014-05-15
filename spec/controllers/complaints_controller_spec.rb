require 'spec_helper'

describe ComplaintsController do
  let (:john) { Factory::UserFactory.user } 
  let!(:complaint_by_john) { Factory::UserComplaint.complaint( john ) }
  let (:chad)   { Factory::UserFactory.user( 'chad' ) }
  let!(:complaint_by_chad) { Factory::UserComplaint.complaint( chad ) }
  let (:brad)   { Factory::UserFactory.user( 'Grad' ) }

  before do
    sign_in john
  end

  describe "#index" do
    it "should call" do 
      expect(Complaint).to receive(:all)
      expect(response.status).to eql(200)
      get :index
    end
  end

  describe "#new" do
    it "should call" do 
      expect(Complaint).to receive(:new)
      expect(response.status).to eql(200)
      get :new
    end
  end
  
  describe "#edit" do
    context "complaint written by john" do
      it "should be found" do
        expect(Complaint).to receive(:find).with(complaint_by_john.id.to_s)
          .and_return(complaint_by_john)
        get :edit, id: complaint_by_john.id
        expect(response.status).to eql(200)
      end
    end

    context "complaint written by chad" do
      it "should be prevented from being edited" do
        expect(Complaint).to receive(:find).with(complaint_by_chad.id.to_s)
          .and_return(complaint_by_chad)
        get :edit, id: complaint_by_chad.id
        expect(response.status).to eql(403)
      end
    end
  end

  describe "#update" do
    context "complaint written by chad" do
      it "should be prevented from updating" do
        expect(Complaint).to receive(:find).with(complaint_by_chad.id.to_s)
          .and_return(complaint_by_chad)
        post :update, { :id => complaint_by_chad.id, 
          :complaint => { :title => "" , :body => "new body" } }
        expect(response.status).to eql(403)
      end
    end
    context "complaint written by john" do
      describe "complaint with invalid data" do
        it "should not be updated" do
          expect(Complaint).to receive(:find).with(complaint_by_john.id.to_s)
            .and_return(complaint_by_john)
          post :update, { :id => complaint_by_john.id, 
              :complaint => { :title => "" , :body => "new body" } }
          expect( complaint_by_john ).to_not be_valid
        end
      end
      describe "complaint with valid data" do
        it "should update complaint" do
          expect(Complaint).to receive(:find).with(complaint_by_john.id.to_s)
            .and_return(complaint_by_john)
          post :update, { :id => complaint_by_john.id, 
              :complaint => { :title => "new title", :body => "new body" } }
          expect(complaint_by_john.title).to eql("new title")
          expect(complaint_by_john.body).to eql("new body")
        end
      end
    end
  end

  describe "#relinquished_by_user" do
    before do
      @controller.stub(:current_user).and_return(brad)
    end

    describe "complaint and user exist" do 
      it "should remove user from advocator list" do
        brad.advocates( complaint_by_john )
        expect(complaint_by_john.advocators).to include(brad)

        post :relinquished_by_user, { :id => complaint_by_john.id } 
        expect(complaint_by_john.advocators).not_to include(brad)

        expected_json = { :id => complaint_by_john.id, 
          :advocators => [] }
        expect(response.body).to eql( expected_json.to_json )
      end
    end

  end

  describe "#advocated_by_user" do
    before do
      @controller.stub(:current_user).and_return(brad)
    end

    describe "complaint and user exist" do 
      it "should update advocators list" do
        expect(complaint_by_john.has_advocators?).to be(false)
        expect {                                                    \
          post :advocated_by_user, { :id => complaint_by_john.id }  \
        }.to                                                        \
        change {                                                    \
          complaint_by_john.has_advocators?                         \
        }.from(false).to(true)                                  

        expected_json = { :id => complaint_by_john.id, 
          :advocators => complaint_by_john.advocators.map { |u| u.email } 
        }
        expect(response.body).to eql( expected_json.to_json )
      end
    end 

    describe "invalid complaint's id" do
      it "should response" do
        post :advocated_by_user, { :id => 0 }
        expect(response.status).to eql(400)
      end
    end
  end
end

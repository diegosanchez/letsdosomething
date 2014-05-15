require 'spec_helper'

describe Complaint do
  let(:author)                { Factory::UserFactory.user( 'author' ) } 
  let(:john)                  { Factory::UserFactory.user( 'john' ) }
  let(:chad)                  { Factory::UserFactory.user( 'chad' ) }
  let(:complaint)             { Factory::UserComplaint.complaint( author ) }
  let!(:ignored_agreement)     { 
    complaint = Factory::UserComplaint.complaint( author, 
      "Companies ignored the agreement", "long description" )

    chad.advocates( complaint )
    john.advocates( complaint )

    complaint
  }

  describe "top" do
    it "should return most popular complaint" do
      expect( Complaint.top(1) ).to include( ignored_agreement )
    end
  end

  describe "creation" do
    it "shouldn't create a complaint without mandatorie fields" do
      c = Complaint.new
      expect(c).not_to be_valid
    end

    it "should create a complaint signed by author" do
      c = Complaint.create( :author => author, 
                           :title => "Price raises", 
                           :body => "long body " * 512 )
      expect(c.author).to eql(author)
    end

    it "should not be valid without an author" do
      c = Complaint.new( :title => "Price raises", :body => "body" )
      expect(c).not_to be_valid
    end

  end

  describe "author advocates a complaint" do
    it "author advocation should be ignored" do
      expect { 
        author.advocates( complaint )
      }.not_to change {
        complaint.advocators.size
      }
    end
  end

  describe "author writes a complain" do
    before do
      Complaint.create( :author => author, :title => "Price raises", 
        :body => "long body " * 512 )
    end

    it "should grab the right author" do
      c = Complaint.first 
      expect(c).not_to be(nil)
      expect(c.author).to eql(author)  
    end
  end

  describe "user advocates the complaint" do
    it "should has advocators" do
      expect(ignored_agreement.has_advocators?).to be(true)
    end

    it "should has advocators set which doesn't include author" do
      expect(ignored_agreement.advocators).to include( chad, john )
      expect(ignored_agreement.advocators).not_to include( author )
    end

    it "advocator and author should belong the complaint" do
      john.advocates( complaint )
      expect(complaint.users(true)).to include( john, author )
      expect(complaint.users(true)).not_to include( chad )
      expect(complaint.author).to eql(author)
    end

    describe "user advocates twice" do
      it "should ignore the second advocation" do
        expect(complaint.advocators).not_to include(john)
        john.advocates( complaint )
        expect(complaint.advocators).to include(john)
        expect {
          john.advocates( complaint )
        }.not_to change {
          complaint.advocators
        }
      end
    end
  end

  describe "user relinquishes the complaint" do
    it "should not belong to the advocators list" do
      expect(ignored_agreement.users(true)).to include( john, chad, author )
      chad.relinquishes( ignored_agreement )
      expect(complaint.users(true)).not_to include( chad )
      expect(ignored_agreement.users(true)).to include( john, author )
    end
  end

  describe "user relinquishe a complaint" do
    it "should not be posible for author relinquishe a complaint" do
      expect(ignored_agreement.author).to eql( author )
      author.relinquishes( ignored_agreement )
      expect(ignored_agreement.author).to eql( author )
      expect(ignored_agreement.users(true)).to include( john, author )
    end
    pending "author should be able to relinquishe a complaint"
  end

  describe "user finds complaint" do
    before do
      # Both code line forced complaints creation
      complaint        
      ignored_agreement
    end

    it "should return complaints written by author" do
      collection = Complaint.by_author( author )
      expect(collection).to include( complaint, ignored_agreement )
    end
  end
end 

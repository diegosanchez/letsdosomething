require 'spec_helper'

describe Proof do

  describe "#valid?" do
    it "should be valid a proof created with all datas" do
      proof = Proof.new( :space => :dropbox, :file => 'filename.png' )
      expect(proof).to be_valid
      expect(proof.file).to eq( 'filename.png' )
      expect(proof.path).to eq( '/proofs/id/filename.png' )
    end

    it "shouldn't be valid" do
      proof = Proof.new( :space => :drox, :file => 'filename.png' )
      expect(proof).to_not be_valid
    end
  end 

  describe "updating attribute" do
    it "should update id before saving" do
      proof = Proof.create( :space => :dropbox, :file => 'filename.png' )
      expect(proof.file).to eq( 'filename.png' )
      expect(proof.path).to eq( "/proofs/#{proof.id}/filename.png" )
    end
  end

  describe "altering attributes" do
    it "should allow altering attr if it isn't persisted" do
      proof = Proof.new( :space => :dropbox, :file => 'filename.png' )
      expect{ proof.file = 'another_name.png' }.to change( proof, :path ) \
          .from( '/proofs/id/filename.png')                               \
          .to( '/proofs/id/another_name.png' )
    end

    it "shouldn't allow altering attr once persisted" do
      proof = Proof.create( :space => :dropbox, :file => 'filename.png' )
      expect { proof.file = 'another_name.png' }.to raise_error(StandardError)
    end
  end
end

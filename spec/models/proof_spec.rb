require 'spec_helper'

describe Proof do
  let(:prove) { Proof.new( :space => :dropbox, :path => 'filename.png' ) }

  describe "#new" do
    it "should be valid a prove created with all datas" do
      expect(prove).to be_valid
      expect(prove.path).to eq( 'proves/filename.png' )
    end
  end 

  describe "altering attributes" do
    it "should allow altering attr if it isn't persisted" do
      expect{ prove.path = 'another_name.png' }.to  \
        change( prove, :path )                      \
          .from( 'proves/filename.png')             \
          .to( 'proves/another_name.png' )
    end

    it "shouldn't allow altering attr once persisted" do
      prove.save
      expect { prove.path = 'another_name.png' }.to raise_error(StandardError)
    end
  end
end

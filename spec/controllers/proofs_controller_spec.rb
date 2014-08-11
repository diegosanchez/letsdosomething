require 'spec_helper'

describe ProofsController do
  let(:storage) { double() }

  describe "#content" do
    it "should call" do 
      expect( Storage::Repository ).to receive(:new).and_return( storage )
      expect( storage ).to receive(:download) \
        .and_return( [ 'file_content', {} ] )

      expect( Proof ).to  receive(:find) \
        .and_return( double( { :id => 1, :path => 'whatever_path_is' } ) )

      expect( @controller ).to receive( :send_data ).with( 'file_content' ) \
        .and_return { @controller.render nothing: true }

      get :content, id: 1
    end
  end
end


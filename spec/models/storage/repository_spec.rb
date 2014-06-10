require 'spec_helper.rb'

describe Storage::Repository do
  before(:all) do
    ENV['DROPBOX_TOKEN']="12345678901234567890"
  end

  let(:storage)           { Storage::Repository.new }
  let(:file_path)         { '/test.txt' }
  let(:missing_file_path) { '/missing_file.txt' }
  let(:content)           { 'file content' }

  it "should upload files" do
	  VCR.use_cassette('dropbox_upload_new_file') do
	  	response = storage.upload(file_path, content)
      expect( response ).to include ( { "bytes"     => content.length } )
      expect( response ).to include ( { "path"      => file_path      } )
      expect( response ).to include ( { "mime_type" => "text/plain"   } )
	  end
  end

  it "should delete a file" do
	  VCR.use_cassette('dropbox_delete_file') do
	  	response = storage.delete(file_path)
      expect( response ).to include ( { "bytes"       => 0          } )
      expect( response ).to include ( { "path"        => file_path  } )
      expect( response ).to include ( { "is_deleted"  => true       } )
	  end
  end

  it "should download a file" do
	  VCR.use_cassette('dropbox_download_file') do
	  	content, metadata = storage.download(file_path)

      expect( content ).to eql( content )

      expect( metadata ).to include ( { "bytes"     => content.length } )
      expect( metadata ).to include ( { "path"      => file_path      } )
      expect( metadata ).to include ( { "mime_type" => "text/plain"   } )
	  end
  end

  describe "missing resources" do
    it "should raise error wether file doesn't exist" do
      VCR.use_cassette('dropbox_download_missing_file') do
        expect {storage.download(missing_file_path)}.to raise_error(RepositoryError)
      end
    end

    it "should raise error wether user delete a file that doesn't exist" do
      VCR.use_cassette('dropbox_delete_missing_file') do
        expect {storage.delete(missing_file_path)}.to raise_error(RepositoryError)
      end
    end
  end
end

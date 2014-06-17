require 'dropbox_sdk'

class RepositoryError < StandardError
  def initialize(storage_error)
    super(storage_error)
  end
end

module Storage
  class Repository
    def initialize
      @client = DropboxClient.new(ENV['DROPBOX_TOKEN'])
    end

    def upload( remote_file_path, file_content )
      @client.put_file( remote_file_path, file_content, true )
    end

    def download( remote_file_path )
      begin
        @client.get_file_and_metadata( remote_file_path )
      rescue DropboxError => e
        raise RepositoryError.new(e)
      end
    end

    def delete( remote_file_path )
      begin
        @client.file_delete( remote_file_path )
      rescue DropboxError => e
        raise RepositoryError.new(e)
      end
    end
  end
end

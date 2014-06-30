class ProofsController < ApplicationController
  def content
    storage = Storage::Repository.new
    proof = Proof.find( params[:id] )

    file, metadata = storage.download( proof.path )

    send_data file
  end
end

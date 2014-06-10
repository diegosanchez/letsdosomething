class Proof < ActiveRecord::Base
  def self.spaces
    [ :dropbox ]
  end

  attr_accessible :path, :space

  validates :path, :space, :presence => true
  validates :space, inclusion: { in: Proof.spaces } 

  belongs_to :complaint

  def path=( file_path )
    raise StandardError if self.persisted?
    write_attribute(:path, "proves/#{file_path}" )
  end
end

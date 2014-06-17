class Proof < ActiveRecord::Base
  def self.spaces
    [ :dropbox ]
  end

  attr_accessible :file, :space
  validates :space, inclusion: { in: Proof.spaces } 

  def path
    "/proofs/#{(self.id.nil?) ? 'id' : self.id}/#{self.file}"
  end

  def file=(f)
    raise StandardError if self.persisted?
    write_attribute( :file, f )
  end
end


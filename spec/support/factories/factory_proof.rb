module Factory
  class ProofFactory
    def self.proof( file = 'image001.png' )
      Proof.create( :space => :dropbox, :path => file )
    end
  end
end

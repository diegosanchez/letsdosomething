module Factory
  class UserComplaint
    def self.complaint( author = nil, title = "an complaint", 
      body = "body of complaint" ) 
      Complaint.create( :author => author || User.first, :title => title,
        :body => body )
    end
  end
end

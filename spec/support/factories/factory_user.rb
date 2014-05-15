module Factory
  class UserFactory
    def self.user( name = "john" )
      User.create( :email => "#{name.strip.downcase}@domain.com",
        :password => "weak_pwd", :password_confirmation => "weak_pwd" )
    end
  end
end

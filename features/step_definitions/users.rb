And /^bunch of user enrolled$/ do 
  (1..10).each do 
    User.create( :email => "#{Faker::Internet.email}",
                :password => 'weak_password',
                :password_confirmation => 'weak_password' )
  end
end


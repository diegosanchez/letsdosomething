# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
require 'faker'

password = 'weak_password'

# Authors
john = User.create( :email => 'john@letsdosth.com', 
              :password => password, :password_confirmation => password )
chad = User.create( :email => 'chad@letsdosth.com', 
              :password => password, :password_confirmation => password )

# Bunch of users
(1..10).each do 
  User.create( :email => "#{Faker::Internet.email}",
              :password => 'weak_password',
              :password_confirmation => 'weak_password' )
end

        
chad_complaint = Complaint.create( :title => 'chad complaint', :body => Faker::Lorem.sentences,
  :author => chad );
john_complaint = Complaint.create( :title => 'john complaint', :body => Faker::Lorem.sentences,
  :author => chad );

(1..5).each do
  [chad_complaint, john_complaint].each do |c|
    User.all.shuffle.first.advocates( c )
  end
end

module ComplaintModule 

  def conjugate( verb )
    return verb + "ed" unless verb[-1] == "e" 
    verb + "d" 
  end

  def grab_complaint( title )
    find(:xpath, "//p[contains(text(), '#{title}')]/../../.." )
  end

  def action_link( action, complaint = nil)
    complaint ||= Complaint.first

    # It selects the anchor which triggers ajax request for specifed action
    query = "//a[contains(@class, '#{action}')]/" \
            "../../"  \
            "form[@action='complaints/#{complaint.id}/" \
            "#{conjugate(action)}_by_user']/a"
    find(:xpath, query)
  end 
end

World( ComplaintModule )

Given /^'(.*)' was written$/ do |complaint_title|
  author = User.find_by_email( grab_email_from( complaint_title ) )
  c = Complaint.create!( :title => complaint_title, :body => Faker::Lorem.sentences,
    :author => author );

  # Users advocate the complaint
  self.create_advocators.each do |u|
    u.advocates( c )    
  end
end

When "User visits 'complaints'" do 
  visit( complaints_path )
end

Then /^User sees '(.*)' complaints and it's advocators$/ do |complaint_title|
  author = User.find_by_email( grab_email_from( complaint_title ) )
  Complaint.by_author( author ).each do |complaint|
    page.should have_content( complaint.body )
    page.should have_content( complaint.title )

    complaint.advocators.each do |u| 
      page.should have_content( u.email )
    end
  end
end

Then /^'(.*)' sees the complaint titled '(.*)'$/ do |name, title|
  page.should have_content( title )
  page.should have_content( "Body of my #{title}" )
end

Given /^'(.*)' visits new complaint page$/ do |name|
  visit( new_complaint_path ) 
end

Given /^'(.*)' advocated '(.*)'$/ do |user_name, complaint_title|
  complaint = Complaint.find_by_title( complaint_title )
  user = User.find_by_email( email_from( user_name ) )
  user.advocates(complaint)
end

When /^'(.*)' writes the '(.*)'$/ do |author, complain_title|
  fill_in( 'Title', :with => complain_title )
  fill_in( 'Body', :with => "Body of my #{complain_title}")
  click_on( 'Create' ) 
end

When /^'(.*)' advocates '(.*)'$/ do |user, complaint_title|
  complaint = Complaint.find_by_title( complaint_title )
  action_link( 'advocate', complaint ).click()
end

When /^'(.*)' relinquishes '(.*)'$/ do |user, complaint_title|
  complaint = Complaint.find_by_title( complaint_title )
  action_link( 'relinquish', complaint ) .click()
end

Then /^'(.*)' contains '(.*)' as advocator$/ do |complaint_title, user|
  grab_complaint( complaint_title ).should have_content( email_from(user))
end

Then /^'(.*)' doesn't contain '(.*)' as advocator any more$/ do |complaint_title, user_name| 
  grab_complaint( complaint_title ).should_not 
    have_content( email_from(user_name) )
end

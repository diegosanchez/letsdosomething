module WebHelper 
  def path( url )
    case url
    when /^[hH]ome.*page$/
      return '/'
    else
      raise RuntimeError
    end
  end
end

World(WebHelper)

And /^visit '(.*)'$/ do |url|
  visit path(url) 
end

Then /^should see '(.*)'$/ do |content|
  expect(page).to have_content(content)
end

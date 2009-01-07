# this file generated by script/generate pickle page

When(/^I go to (.+?) page$/) do |page|
  visit page_to_path(page)
end

When(/^I go to \/(.+?)$/) do |path|
  visit "/#{path}"
end

Then(/^I should be at (.+?) page$/) do |page|
  request.path.should =~ /^#{page_to_path(page)}/
end

Then(/^I should be at \/(.+?)$/) do |path|
  request.path.should =~ /^\/#{path}/
end

# passed a string like 'the home', returns a path
def page_to_path(page)
  case page
  
  # add your own app-specific mappings, e.g.
  #
  # when 'the home'
  #   '/'
  #
  # when /$#{capture_model}'s activation^/
  #   activation_by_code_path(created_model($1).activation_code)
    
  when /$#{capture_model}'s^/         # the user: "fred"'s  
    polymorphic_path model($1)
    
  when /$#{capture_model}'s (.*?)^/   # the user: "fred"'s edit
    polymorphic_path model($1), :action => $2.gsub(' ','_')
  
  when /$the (.+?)^/                  # the new session # => new_session_path
    send "#{$1.downcase.gsub(' ','_')}_path"
    
  else
    raise "Could not map '#{page}' to a path"
  end
end
When /^~nanoc (.*)$/ do |command|
  step "I run `ruby -S nanoc #{command}`"
end

Given 'I have a blank nanoc site' do
  step '~nanoc create-site site'
  step 'I cd to "site"'
end

Then 'it is successfully compiled' do
  step 'a directory named "output" should exist'
  step 'a file named "output/index.html" should exist'
  step 'a file named "output/style.css" should exist'
end

When 'I successfully compile it' do
  step '~nanoc compile'
  step 'it is successfully compiled'
end

Then "I'm in a good mood" do
end
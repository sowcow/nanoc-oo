Given 'I have a blank nanoc site' do
  step '~nanoc create-site site'
  step 'I cd to "site"'
end

Given 'I have a wrapped nanoc site' do
  step 'I have a blank nanoc site'
  step 'I copy the nanoc-oo wrapper here'
end

When 'I copy the nanoc-oo wrapper here' do
  copy_all from: 'wrapper/.', to: current_dir
end

When /^~nanoc (.*)$/ do |command|
  step "I run `ruby -S nanoc #{command}`"
end

When 'I successfully compile it' do
  step '~nanoc compile'
  step 'it is successfully compiled'
end

Then 'it is successfully compiled' do
  step 'a directory named "output" should exist'
  step 'the file "crash.log" should not exist'
end
Step '[>$] ?nanoc *' do |command|
  step "I successfully run `ruby -S nanoc #{command}`"
end

Given 'I have a default nanoc site' do
  step '>nanoc create-site site'
  step 'I cd to "site"'
end

When 'I successfully compile it' do
  step '>nanoc compile'
  step 'it is successfully compiled'
end

Then 'it is successfully compiled' do
  step 'a directory named "output" should exist'
  step 'the file "crash.log" should not exist'
end
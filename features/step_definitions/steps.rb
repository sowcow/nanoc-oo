When /^~nanoc (.*)$/ do |command|
  step "I run `ruby -S nanoc #{command}`"
end

Given 'I have a blank nanoc site' do
  #step "I run `ruby -S nanoc create-site site`"
  step '~nanoc create-site site'
  step 'I cd to "site"'
end

When 'I successfully compile it' do
  step "~nanoc compile"
  step 'a directory named "output" should exist'
  step 'a file named "output/index.html" should exist'
  step 'a file named "output/style.css" should exist'
end

Then "I'm in a good mood" do
end

__END__
When /^I run nanoc(.*)$/ do |command|
  step "I run `ruby -S nanoc#{command}`"  #~ ruby -S nanoc <command>
end

When 'I create nanoc site' do
  steps '
    When I run nanoc create-site site
  '
  #  When I cd to "site"
  #'
end

When 'I compile it' do
  #step 'I run nanoc compile'
end

Then 'I see it compiled successfully' do
  #steps '
  #  Then a directory named "output" should exist
  #'
  #  Then a file named "output/index.html" should exist
  #  Then a file named "output/stylesheet.css" should exist
  #'
end
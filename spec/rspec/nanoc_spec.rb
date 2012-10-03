require 'support/all'

describe 'nanoc' do
  it 'should create site' do
    Dir.should exist SITE
  end
  it 'should delete index.html' do
    File.should_not exist "#{SITE}/content/index.html"
  end  
  it 'should delete stylesheet.css' do
    File.should_not exist "#{SITE}/content/stylesheet.css"
  end  
end
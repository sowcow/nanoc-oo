require 'support/all'

describe 'wrapper' do
  it 'should overwrite Rules file' do
    File.read("#{SITE}/Rules").should == File.read("#{WRAP}/Rules")
  end
  
  it 'should delete lib/all file' do
    File.should_not exist "#{SITE}/lib/all.rb"
  end  
  
  it 'should add textual file extensions (.slim) to config.yaml' do
    require 'yaml'
    filters = YAML.load(File.read("#{SITE}/config.yaml"))['text_extensions']
    filters.should be_a Array
    filters.should include 'erb'
    filters.should include 'slim'
  end    
end
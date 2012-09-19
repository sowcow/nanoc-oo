require 'support/all'

describe 'wrapper' do
  it 'should overwrite Rules file' do
    File.read("#{SITE}/Rules").should == File.read("#{WRAP}/Rules")
  end
  
  it 'should delete lib/all file' do
    File.should_not exist "#{SITE}/lib/all.rb"
  end  
end
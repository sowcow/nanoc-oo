require 'support/all'

describe 'wrapper' do
  it 'should overwrite Rules file' do
    File.read("#{SITE}/Rules").should == File.read("#{WRAP}/Rules")
  end
end
require 'support/all'
require_lib

describe 'filter for file' do
  it 'should work' do
    FilterFor['file.html.erb'].should == :erb
  end
  it 'should return :erb for html, htm' do
    FilterFor['file.html'].should == :erb
    FilterFor['file.htm'].should  == :erb
  end
end
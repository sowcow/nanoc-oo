require 'support/all'
require_lib

describe 'filter for file' do
  it 'should work' do
    FilterFor['file.html.erb'].should == :erb
  end
end
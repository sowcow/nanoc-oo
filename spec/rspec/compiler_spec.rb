require 'support/all'

describe 'compiler' do
  it 'should compile without errors' do
    File.should exist "#{SITE}/output/index.html"
    File.should_not exist "#{SITE}/crash.log"
  end
end
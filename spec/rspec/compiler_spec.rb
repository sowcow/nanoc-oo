require 'support/all'

describe 'compiler' do
  it 'should compile without errors' do
    Dir.should exist "#{SITE}/output"
    File.should_not exist "#{SITE}/crash.log"
  end
end
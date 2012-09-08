require 'support/all'

describe 'nanoc' do
  it 'should create site' do
    Dir.should exist SITE
  end
end
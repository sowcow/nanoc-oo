def wrap wrap=WRAP, site=SITE
  require 'FileUtils'
  FileUtils.cp_r "#{wrap}/.", site
end

RSpec.configure do |config|
  config.before(:all) do
    wrap
  end
end
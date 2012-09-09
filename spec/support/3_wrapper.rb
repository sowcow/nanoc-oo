def wrap
  require 'FileUtils'
  FileUtils.cp_r "#{WRAP}/.", SITE
  File.delete "#{SITE}/lib/all.rb"
end

RSpec.configure do |config|
  config.before(:all) do
    wrap
  end
end
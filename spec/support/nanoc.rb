SITE = 'test-site'

def clean site=SITE
  require 'FileUtils'
  FileUtils.rm_rf site if Dir.exist? site
end

def start site=SITE
  clean
  `nanoc create-site #{site}`
end

RSpec.configure do |config|
  config.before(:all) do
    start
  end

  config.after(:all) do
    clean
  end
end
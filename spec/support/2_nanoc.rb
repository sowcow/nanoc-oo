require 'FileUtils'

def clean site=SITE
  FileUtils.rm_rf site if Dir.exist? site
end

def start
  clean
  `nanoc create-site #{SITE}`
end

RSpec.configure do |config|
  config.before(:all) do
    start
  end

  config.after(:all) do
    clean
  end
end
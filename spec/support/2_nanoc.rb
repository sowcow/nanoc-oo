require 'FileUtils'

def clean
  rm_rf SITE
end

def rm_rf dir
  FileUtils.rm_rf dir if Dir.exist? dir
end


def start
  clean
  `nanoc create-site #{SITE}`
  File.delete "#{SITE}/content/index.html"
  File.delete "#{SITE}/content/stylesheet.css"
end

RSpec.configure do |config|
  config.before(:all) do
    start
  end

  config.after(:all) do
    clean
  end
end
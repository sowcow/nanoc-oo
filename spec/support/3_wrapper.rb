def wrap
  require 'fileutils'
  FileUtils.cp_r "#{WRAP}/.", SITE
end

def add_filters filters, config = "#{SITE}/config.yaml"
  text = File.read(config)
  text[/text_extensions: ?\[()/, 1] = filters.map{|x| " '#{x}'," }.join
  File.write config, text
end

RSpec.configure do |config|
  config.before(:all) do
    wrap
    add_filters ['slim']
  end
end
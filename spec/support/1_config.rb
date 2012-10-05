SITE = 'tmp'
WRAP = 'wrapper'

def require_lib
  require File.expand_path "#{WRAP}/lib/all.rb"
end

def require_classes
  Dir["#{WRAP}/lib/classes/*.rb"].each {|file| require File.expand_path file }
end


RSpec.configure do |config|
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.treat_symbols_as_metadata_keys_with_true_values = true
end

def f
  :focus
end
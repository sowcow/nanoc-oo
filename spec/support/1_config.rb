require 'nanoc-oo'

SITE = 'tmp'
WRAP = NanocOO.wrapper

def require_here dir
  Dir["#{dir}/*.rb"].each {|file| require File.expand_path file }
end

def require_lib
  require_here "#{WRAP}/lib"
end

def require_classes
  require_here "#{WRAP}/lib/classes"
end


RSpec.configure do |config|
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.treat_symbols_as_metadata_keys_with_true_values = true
end

def f
  :focus
end

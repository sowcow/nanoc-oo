SITE = 'temp-test-site'
WRAP = 'wrapper'

def require_lib
  require File.expand_path "#{WRAP}/lib/all.rb"
end

RSpec.configure do |config|
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.treat_symbols_as_metadata_keys_with_true_values = true
end

def focus
  :focus
end
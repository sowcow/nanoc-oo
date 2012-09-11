SITE = 'temp-test-site'
WRAP = 'wrapper'
ORIG = 'nanoc-site-not-yet-wrapped'

def require_lib
  require File.expand_path "#{WRAP}/lib/all.rb"
end
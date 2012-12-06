# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nanoc-oo/version'

Gem::Specification.new do |gem|
  gem.name          = "nanoc-oo"
  gem.version       = NanocOO::VERSION
  gem.authors       = ["TODO: Write your name"]
  gem.email         = ["TODO: Write your email address"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'cucumber'
  gem.add_development_dependency 'aruba'
  gem.add_development_dependency 'slim'
  gem.add_development_dependency 'nokogiri'
  gem.add_development_dependency 'kramdown'
  gem.add_development_dependency 'sass'

  gem.add_dependency 'nanoc'
  gem.add_dependency 'thor'

  gem.executables << 'nanoc-oo'
end

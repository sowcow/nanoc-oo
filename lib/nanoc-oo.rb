require "nanoc-oo/version"

module NanocOO
  include FileUtils
  
  def create_site name
  	`nanoc create-site #{name}`
  	wrap name
  end

  def wrap dir
  	cp_r wrapper+'/.', dir
  end

  def wrapper
  	File.join Gem.datadir('nanoc-oo'),  'wrapper'
  end

  extend self
end

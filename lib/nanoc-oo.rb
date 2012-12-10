require "nanoc-oo/version"
require 'fileutils'

module NanocOO
  include FileUtils
  
  def create_site name, blank=false
    system "nanoc create-site #{name}"
    wrap name
    delete_content name if blank
  end

  def wrap dir
    cp_r wrapper+'/.', dir
  end

  def wrapper
    File.join Gem.datadir('nanoc-oo'),  'wrapper'
  end

  def delete_content dir
    rm_r Dir.glob File.join(dir,'content','*')
  end

  extend self
end

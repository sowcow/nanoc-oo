require "nanoc-oo/version"
require 'thor'

THIS_GEM = 'nanoc-oo'

class ForcedDataCopier < Thor
  include Thor::Actions
  class_option :force, type: :boolean, default: true

  desc 'copy',''
  def copy source, dest
    directory source, dest
  end

  def self.source_root
    Gem.datadir(THIS_GEM)
  end
end

class Force < Thor
  include Thor::Actions
  class_option :force, type: :boolean, default: true

  def self.remove_file file
    new.remove_file file
  end
end


module NanocOO
  def create_site name, blank=false
    system "nanoc create-site #{name}"
    wrap name
    delete_content name if blank
  end

  def wrap dir
    copier = ForcedDataCopier.new.copy 'wrapper', dir

    #prepend_file join(dir,'Rules'), File.read(join(wrapper,'Rules'))
    #directory 'lib', dir
    #cp_r wrapper+'/.', dir
#    act = Thor::Actions.new :force
#    act.directory wrapper+'/.', dir
  end

  def data_dir
    Gem.datadir('nanoc-oo')
  end

  def wrapper
    join data_dir, 'wrapper'
  end

  def delete_content dir
    Dir.glob(join(dir,'content','*')).each do |supposedly_file|
      Force.remove_file supposedly_file
    end
  end

  extend self

  # def source_root
  #   File.expand_path(File.dirname(__FILE__))
  # end
end


BEGIN{
  def join *a; File.join *a end
}
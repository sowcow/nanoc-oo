if gem_available? 'simplecov'

  require 'simplecov'
  SimpleCov.start do
    add_filter '/spec/'
  end
end


BEGIN{
  def gem_available?(name)
    Gem::Specification.find_by_name(name)
  rescue Gem::LoadError
    false
  rescue
    Gem.available?(name)
  end
}
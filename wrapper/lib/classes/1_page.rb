def is_binary_file? file
  require 'ptools'
  File.binary? file
end

module PageDefaults
  def route
    identifier.chop + (!html?? ".#{ item[:extension] }" : '/index.html')
  end
  
  # uses FakeItem#file or NanocItem#[:binary]
  #
  def binary?
    item.respond_to?(:file) ? is_binary_file?(item.file) : item[:binary]
  end
  
  def html?
    (not binary?) && (not css?)
  end
  
  def css?
    extension.split('.').find { |ext| ext =~ /(css|sass|scss)/ }
  end
  
  def extension
    item[:extension]
  end
  
  PRIORITY = 0
end

class Page
  include PageDefaults
  attr_reader :identifier
  attr_reader :item
  
  def initialize item
    @item = item
    @identifier = item.identifier
  end
  
  def self.accept? identifier
    identifier =~ self::GOOD_ID ? true : false  
  end
  
  def representation
    rep
  end
  def rep
    :default
  end
end
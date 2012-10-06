def is_binary_file? file
  require 'ptools'
  File.binary? file
end

module Hidable
  def route *a
    return nil if hidden?
    super
  end

  # def compile *a
  #   return nil if hidden?
  #   super
  # end

  private
  def hidden?
  #  item[:hidden] == true
  end
end

module PageDefaults
  def route
    identifier.chop + (!html?? ".#{ item[:extension] }" : '/index.html')
  end

  def compile_children context, items_context
    children(items_context).each do |child|
      ::Builder.build! child, context, items_context
    end
  end  

  def children context
    direct_children context
  end
  
  def direct_children context
    context.items.select { |items| items.identifier =~ %r|^#{ Regexp.escape identifier }[^/]+/$| }
  end
  
  def compile context
    filter context
    apply_layout context
    after_compile context
  end

  def filter context
    context.filter @@filters[last_extension] if @@filters[last_extension]
  end
  def apply_layout context
    context.layout layout if layout
  end
  def layout
    self.class::LAYOUT if defined? self.class::LAYOUT
  end
  def after_compile context
    context.filter :relativize_paths, type: kind if kind  
  end

  def kind
    case
    when html? then :html
    when css? then :css
    end
  end
  
  
  def css?
    really_css?
  end
  
  def really_css?
    extension.split('.').find { |ext| ext =~ /^(#{ CSS_EXTENSIONS })$/ } ? true : false
  end    


  
  # uses FakeItem#file or NanocItem#[:binary]
  #
  def binary?
    item.respond_to?(:file) ? is_binary_file?(item.file) : item[:binary]
  end
  
  def html?
    really_html?
  end
  
  def really_html?
    extension.split('.').find { |ext| ext =~ /^(#{ HTML_EXTENSIONS })$/ } ? true : false
  end  
  
  def extension
    item[:extension] or self.class::EXT
  end
  
  def last_extension
    extension[/[.](.+?)$/, 1] or extension
  end
  
  EXT = ''
  CSS_EXTENSIONS = 'css|sass|scss'
  HTML_EXTENSIONS = 'html|htm|slim|haml|md'
  PRIORITY = 0
  @@filters = {'md' => :kramdown, 'slim' => :slim, 'erb' => :erb}
end

class Page
  include PageDefaults
  include Hidable
  attr_reader :item
  
  def initialize item
    @item = item
  end
  
  def preprocess context
  end

  def do_preprocess context
    preprocess context
  ensure
    @processed = true
  end

  def processed?
    @processed
  end

  def identifier
    item.identifier
  end
  def identifier= value
    item.identifier = value
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

class UndefinedPage < Page
  PRIORITY = fixnum_min = -(2**(0.size * 8 -2))
  def self.accept? *a; true end

  def route *a; end
  def compile *a; end
  def preprocess *a; end
end
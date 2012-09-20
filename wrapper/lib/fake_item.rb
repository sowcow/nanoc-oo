class FakeItem
  attr_reader :file
  attr_reader :identifier
    
  def initialize file
    @file = file
    @identifier = get_identifier
    @values = {}
  end
  
  def +@
    @values[:object]
  end 
  def []= key, value
    @values[key] = value
  end
  def [] key
    @values[key]
  end  
  
  private
  def get_identifier
    (@file.sub(/.+?\//, '/').sub(/\.[^\/]+/, '') + '/').sub(%r[/index/$], '/')
  end
end
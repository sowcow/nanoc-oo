class FakeItem
  attr_reader :file
  attr_reader :identifier
    
  def initialize file
    @file = file
    @identifier = get_identifier
  end
  
  private
  def get_identifier
    (@file.sub(/.+?\//, '/').sub(/\.[^\/]+/, '') + '/').sub(%r[/index/$], '/')
  end
end
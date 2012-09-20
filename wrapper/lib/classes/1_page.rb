class Page
  attr_reader :identifier
  PRIORITY = 0
  
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
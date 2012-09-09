class FakeItems
  attr_reader :items
  
  def initialize where
    @items = Dir["#{where}/**/*.*"].map { |item| FakeItem.new item }
  end
end
class FakeItems
  attr_reader :items
  
  def initialize where
    @items = Dir["#{where}/**/*"].reject { |those| File.directory? those }.map { |item| FakeItem.new item }
  end
end
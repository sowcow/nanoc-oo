class FakeItems
  attr_reader :items
  
  def initialize where
    all = Dir["#{where}/**/*"]
    files = all.reject { |those| File.directory? those }.map { |item| FakeItem.new item }
    dirs  = all.select { |those| File.directory? those }.map { |item| FakeDir.new item  }
    dirs.reject! { |dir| files.find { |file| file.identifier == dir.identifier } }
    @items = files + dirs
  end
end
require 'support/all'
require_lib

describe FakeItems do
  context '#items' do
    let(:dir){ 'temp-test-fake-items-dir' }

    before :all do
      Dir.mkdir dir
      File.write("#{dir}/1.file", 'data')
      File.write("#{dir}/2.file", 'data')
      File.write("#{dir}/3.file", 'data')
      Dir.mkdir "#{dir}/deep"
      File.write("#{dir}/deep/4.file", 'data')
      File.write("#{dir}/deep/5-file-without-extension", 'data')
      Dir.mkdir "#{dir}/some-dir"
      Dir.mkdir "#{dir}/some.odd.dir1"
      Dir.mkdir "#{dir}/some.odd.dir2"

      5.times do |i|
        Dir.mkdir "#{dir}/some_dir#{i}"
        File.write("#{dir}/some_dir#{i}/index.html.slim", 'data')
      end
    end

    after :all do
      rm_rf dir
    end

    it 'should reflect all files/directories in the given directory (without identical ids)' do
      FakeItems.new(dir).items.first.should be_a FakeItem
      files = FakeItems.new(dir).items.select { |those| those.is_a? FakeItem } 
      dirs  = FakeItems.new(dir).items.select { |those| those.is_a? FakeDir  } 
      files.count.should == 5 + 5
      dirs.count.should == 4 + 0
    end
  end  
end
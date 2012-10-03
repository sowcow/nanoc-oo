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
    end

    after :all do
      rm_rf dir
    end

    it 'should reflect all files(and not directories) in the given directory' do
      FakeItems.new(dir).items.first.should be_a FakeItem
      FakeItems.new(dir).items.count.should == 5
    end
  end  
end
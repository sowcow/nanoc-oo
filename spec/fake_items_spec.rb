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
    end

    after :all do
      require 'FileUtils'
      FileUtils.rm_rf dir
    end

    it 'should reflect all files in the given directory' do
      FakeItems.new(dir).items.first.should be_a FakeItem
      FakeItems.new(dir).items.count.should == 4
    end
  end  
end
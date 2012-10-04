require 'support/all'
require_lib

describe FakeDir do

  describe '#file' do
    let(:name){ 'some.dir' }
    
    it 'is accessible' do
      FakeDir.new(name).file.should == name
    end
  end

  describe '(+self)' do
    let(:item){ FakeDir.new('foo') } 
    let(:value){ 123 } 
    
    it 'should return self[:object]' do
      item[:object] = value
      (+item).should == value
    end
  end

  describe '#identifier' do

    variants = %w[

      given_direcory_name:                 identifier:

      content/canon/some.dir               /canon/some.dir/
      layouts/default_dir                  /default_dir/
      content/index.dir.123                /index.dir.123/
      content/index                        /index/
      content/index.dir                    /index.dir/
      content/index.dir/                   /index.dir/

    ].each_slice(2).drop(1)

    variants.each do |name, identifier|
      it "should be (#{identifier}) when directory name is (#{name})" do
        FakeDir.new(name).identifier.should == identifier
      end
    end  
  end  
end
require 'support/all'
require_lib

describe FakeItem do
  describe '#file' do
    let(:file){ 'some-file.txt' }
    
    it 'is accessible' do
      FakeItem.new(file).file.should == file
    end
  end
  
  describe '(+self)' do
    let(:item){ FakeItem.new('foo') } 
    let(:value){ 123 } 
    
    it 'should return self[:object]' do
      item[:object] = value
      (+item).should == value
    end
  end
  
  describe 'extension' do
    variants = %w[

      given_file_name:                     extension:

      content/canon/index.html.slim        html.slim
      content/canon/style/style.css.sass   css.sass
      cont.ent/index.html.slim             html.slim 
      layouts/default.slim                 slim  

    ].each_slice(2).drop(1) << ['layouts/default', '']
    
    variants.each do |file_name, ext|
      it "should be '#{ext}' when file name is (#{file_name})" do
        FakeItem.new(file_name)[:extension].should == ext
      end
    end     
  end
  
  describe '#identifier' do

    variants = %w[

      given_file_name:                     identifier:

      content/canon/index.html.slim        /canon/
      content/canon/style/style.css.sass   /canon/style/style/
      content/index.html.slim              /
      layouts/default.slim                 /default/    
      layouts/default                      /default/    

    ].each_slice(2).drop(1)

    variants.each do |file_name, identifier|
      it "should be (#{identifier}) when file name is (#{file_name})" do
        FakeItem.new(file_name).identifier.should == identifier
      end
    end  
  end
end
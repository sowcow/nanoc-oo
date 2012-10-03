require 'support/all'
require_lib
require_classes


describe Page do

  describe '#direct_children' do
    let :context do
      items = %w[ index  some  other  one-more  deep/item  deep/item2  deep/item/level3  ].map do |file|
        FakeItem.new "/content/#{file}.html"
      end
      double items: items
    end
    let(:root){ Page.new FakeItem.new '/index' }

    it 'works' do
      root.direct_children(context).map(&:identifier).should =~ %w[ /some/  /other/  /one-more/ ]
    end
  end

  describe '#last_extension' do
    variants = %w[

      given_file_name:                     last_extension:

      content/canon/index.html.slim        slim
      content/canon/style/style.css.sass   sass
      cont.ent/index.html.slim             slim 
      layouts/default.slim                 slim  

    ].each_slice(2).drop(1)
    
    variants.each do |given, ext|
      it "should be '#{ext}' when file name is (#{given})" do
        page = Page.new FakeItem.new given
        page.last_extension.should == ext
      end
    end     
  end
  
  
  describe '#really_html?' do
  
    variants = %w[
      file:             result:

      name.any.slim    true
      name.html.any    true
      name.slim        true  
      name.html        true  
      name.haml        true  
      name.css.sass    false
      name.sass        false
      name.coffee      false
      name.erb         false  
      name.js.erb         false  
      name.any.erb         false  

    ].each_slice(2).drop(1).map{|given,result| [given, (result == 'true')] }
    
    variants.each do |given, result|
      it "should be #{result} when file is '#{given}'" do
        page = Page.new FakeItem.new given
        page.really_html?.should == result
      end
    end  
  end
  
  describe '#really_css?' do
  
    variants = %w[
      file:             result:

      name.any.slim    false
      name.html.any    false
      name.slim        false  
      name.html        false  
      name.haml        false  
      name.coffee      false
      name.erb         false  
      name.sass        true
      name.css.sass    true
      name.js.css      true  
      name.any.scss    true  

    ].each_slice(2).drop(1).map{|given,result| [given, (result == 'true')] }
    
    variants.each do |given, result|
      it "should be #{result} when file is '#{given}'" do
        page = Page.new FakeItem.new given
        page.really_css?.should == result
      end
    end  
  end  
end
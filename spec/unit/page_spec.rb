require 'support/all'
require_lib
require_classes


describe Page do
  describe 'really_html?' do
  
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
end
require 'support/all'
require File.expand_path "#{WRAP}/lib/all"

describe FakeItem do
  context '#identifier' do

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
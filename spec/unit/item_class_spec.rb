require 'support/all'
require_lib


describe ItemClass do
 
  before do
    stub_const 'Page', double
      
    stub_const 'Low', Module.new
    stub_const 'Mid', Module.new
    stub_const 'High', Module.new
      
    stub_const 'High::PRIORITY', 2
    stub_const 'Mid::PRIORITY', 1
    stub_const 'Low::PRIORITY', 0
    
    all.each { |x| x.stub(:accept? => false) }
    (@accepting_one = all.sample).stub(:accept? => true)

    Page.stub(:subclasses){ right_order.shuffle } 
  end
  
  let(:all){ right_order }
  let(:right_order){ [High, Mid, Low] }
  let(:accepting_one){ @accepting_one }
  subject{ ItemClass.new }
  
  describe '.[identifier]' do
    let(:item){ double(identifier: '/') }  

    it 'should return first class that accept identifier' do
      subject[item].should == @accepting_one
    end
  end
 
  describe '.classes' do
    it 'should return all subclasses of Page class sorted by priority in a descending order' do
      subject.classes.should == right_order 
    end
  end
end
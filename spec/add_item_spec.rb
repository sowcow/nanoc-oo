require 'support/all'
require_lib


describe 'Page#preprocess' do
  let(:name){ 'test-page-preprocess' }

  it 'should take context with items as parameter' do
    Page.new('').method(:preprocess).arity.should == 1
  end

  describe '<context> argument' do

    before do
      TempFiles.create "#{ SITE }/lib/classes/#{ name }.rb" do
        "
        class TestingPage < Page
          GOOD_ID = Regexp.new Regexp.escape '/#{ name }/'
          #{ configuration }
        end

        class NewItems < Page
          GOOD_ID = %r|item_|
        end  
        "
      end
    end      
    before do
      create_item("#{ name }.html.erb"){ '<strong><%= item[:value] %></strong>' }
    end

    describe 'value' do
      let(:configuration) do
        "
        def preprocess context
          item[:value] = context.items.count
        end
        "
      end

      it 'reflects items' do
        compile!
        output_file(name)[/<strong>(.+)<\/strong>/, 1].should == '1'
      end
    end

    describe '<<' do
      let(:configuration) do
        '
        def preprocess context
          3.times do |counter|
            context.items << Nanoc::Item.new("", {extension: \'html\'}, "/item_#{ counter }/")
          end
        end
        '
      end

      it 'adds item' do
        compile!
        Dir["#{ SITE }/output/**/*.html"].count.should == 3 + 1  # "/#{ name }.html"
      end
    end
    
    describe 'reject!' do

      context 'configuration 1' do
        let(:configuration) do
          '
          def preprocess context
            context.items.reject! { true }
          end
          '
        end
      
        it 'removes items' do
          compile!
          Dir["#{ SITE }/output/**/*.html"].count.should == 0
        end      
      end
      
      context 'configuration 2' do
        let(:configuration) do
          '
          def preprocess context
            context.items.reject! { |those| those.identifier != identifier }
          end
          '
        end
      
        it 'removes items' do
          compile!
          Dir["#{ SITE }/output/**/*.html"].count.should == 1
        end      
      end      
    end    
  end
end
require 'support/all'
require_lib


describe '=>items configuration through classes' do

  before do
    TempFiles.create "#{SITE}/lib/classes/#{name}.rb" do
"
class TestingPage < Page
  GOOD_ID = Regexp.new Regexp.escape '/#{name}/'
#{configuration}
end"    
    end
  end 

  let(:name){ 'teting-items-and-classes' }
  

  context 'routes' do
    let :configuration do
"
  def route
    '/#{route}/index.html'
  end"      
    end
    let(:route){ 'test-route-changed' }

    describe 'default value' do
      let(:configuration){''}

      
      context 'for .html files' do
        before do
          create_item("#{name}.html"){ lorem }
        end
        
        let(:good){ "#{SITE}/output/#{name}/index.html" }
      
        it 'should work properly' do
          compile!
          File.should exist good
        end
      end
      
      context 'for .png files' do
        before do
          full_name = "#{SITE}/content/#{name}.png"
          TempFiles.create full_name, &->{}
          save_png_image full_name
        end
        
        let(:good){ "#{SITE}/output/#{name}.png" }
      
        it 'should work properly' do
          compile!
          File.should exist good
        end
      end   
      
      context 'for .css files' do
        before do
          full_name = "#{SITE}/content/#{name}.css"
          TempFiles.create full_name do'
            html {
              color: lime;
              outline: solid 10px orange;
            }'
          end
        end
        
        let(:good){ "#{SITE}/output/#{name}.css" }
      
        it 'should work properly' do
          compile!
          File.should exist good
        end
      end
    end    
    
    context 'configured through class' do
      before do
        create_item("#{name}.html"){ lorem }
      end
      #####let(:route){ 'test-route-changed' }      
  
      it 'should be work' do
        compile!
    
        File.should_not exist "#{SITE}/output/#{name}/index.html"
        File.should exist     "#{SITE}/output/#{route}/index.html"
      end
    end 
  end
  
  context 'copiling' do
    context 'filtering' do
      
      let :configuration do'
        def filter context
          context.filter :kramdown
        end'
      end
      
      let(:header){ 'Testing header!' }
      let(:header_md){ "##{header}" }
      let(:header_html){ %r[<h1.*?>#{header}</h1>] }
      
      before do
        create_item "#{name}.html" do
          "##{header}"
        end
      end      
      
      it 'should be configurable' do
        compile!
        output_file(name).should_not include header_md
        output_file(name).should match header_html
      end      
    end
    
    context 'layout' do
    
      before do
        create_item("#{name}.html"){ lorem }
      end
          
      let :configuration do"
        LAYOUT = 'default'"
      end    

      context 'by default' do
        let(:configuration){''}         
        it 'should use no layout' do
          compile!
          output_file(name).should_not match /doctype/i
          output_file(name).should_not include '<head>'
        end
      end
    
      it 'should be configurable' do
        compile!
        output_file(name).should match /doctype/i
        output_file(name).should include '<head>'
      end
    end
    
    context 'after compile' do
    
      before do
        create_item("#{ name }.html"){ link % absolute }
      end
      
      let(:path){ 'path.html' }
      let(:relative){ "../#{path}" }
      let(:absolute){ "/#{path}" }
      let(:link){ "<a href='%s'>link!</a>" }
      
      context 'by default' do
        let(:configuration){''}        
        specify 'paths are relativised' do
          compile!
          output_file(name)[/href=['"](.+?)['"]/, 1].should == relative
        end
      end

      let :configuration do'
        def after_compile *a
        end'
      end
      
      it 'should be configurable' do
        compile!
        output_file(name).should include link % absolute
      end
    end
  end
end
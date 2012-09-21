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
end
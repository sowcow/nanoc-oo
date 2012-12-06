require 'support/all'
require_lib


shared_examples_for 'valid routing' do
  it 'routes properly' do
    compile!
    File.should exist good
  end  
end

shared_examples_for 'produces html' do
  it 'produces html file' do
    compile!
    output_file(name).should match compiled_html
  end  
end


describe '=>items configuration through classes' do

  before do
    TempFiles.create "#{ SITE }/lib/classes/#{ name }.rb" do
      "
      class TestingPage < Page
        GOOD_ID = Regexp.new Regexp.escape '/#{ name }/'
        #{ configuration }
      end
      "
    end
  end
  let(:name){ 'teting-items-and-classes' }
  

  describe '#route' do

    context 'by default' do
      let(:configuration){''}


      context 'for .html files' do
        before do
          create_item("#{ name }.html"){ lorem }
        end
        
        let(:good){ "#{ SITE }/output/#{ name }/index.html" }
      
        include_examples "valid routing"
      end
      
      context 'for .png files' do
        before do
          full_name = "#{ SITE }/content/#{ name }.png"
          TempFiles.create full_name, &->{}
          #save_png_image full_name
        end
        
        let(:good){ "#{ SITE }/output/#{ name }.png" }
      
        include_examples "valid routing"
      end   
      
      context 'for .css files' do
        before do
          full_name = "#{ SITE }/content/#{ name }.css"
          TempFiles.create full_name do'
            html {
              color: lime;
              outline: solid 10px orange;
            }'
          end
        end
        
        let(:good){ "#{ SITE }/output/#{ name }.css" }
      
        include_examples "valid routing"
      end
    end  

    context 'configured through class' do
      let :configuration do
       "
       def route
          '/#{ route }/index.html'
        end
        "
      end
      let(:route){ 'test-route-changed' }

      before do
        create_item("#{ name }.html"){ lorem }
      end
  
      it 'routes properly' do
        compile!
    
        File.should_not exist "#{ SITE }/output/#{ name }/index.html"
        File.should exist     "#{ SITE }/output/#{ route }/index.html"
      end
    end 
  end
  
  describe '#compile' do
    describe 'filtering' do
            
      let(:header){ 'Testing header!' }
      let(:header_md){ "# #{ header }" }
      let(:header_slim){ "h1 #{ header }" }
      let(:compiled_html){ %r[<h1.*?>#{ header }</h1>] }
           
      context 'by default' do
        let(:configuration){''} 
       
        context 'should use last file extension to choose right filter' do
          context 'for slim' do
            before do
              create_item "#{ name }.html.slim" do
                header_slim
              end            
            end
            
            include_examples 'produces html'
          end

          context 'for markdown' do
            before do
              create_item "#{ name }.html.md" do
                header_md
              end            
            end
            
            include_examples 'produces html'
          end
        end
      end

      context 'when configured' do
        let :configuration do'
          def apply_filter context
            context.filter :kramdown
          end'
        end

        before do
          create_item "#{ name }.html" do
            header_md
          end
        end      
      
        include_examples 'produces html'
      end      
    end
    
    context 'layout' do
    
      before do
        create_item("#{ name }.html"){ lorem }
      end
          
      context 'by default' do
        let(:configuration){''}         
        it 'should use no layout' do
          compile!
          output_file(name).should_not match /doctype/i
          output_file(name).should_not include '<head>'
        end
      end

      context 'when configured' do
        let :configuration do"
          LAYOUT = 'default'"
        end    
    
        it 'should be configurable' do
          compile!
          output_file(name).should match /doctype/i
          output_file(name).should include '<head>'
        end
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

      context 'when configured' do
        let :configuration do'
          def after_compile *a
          end'
        end
      
        it 'paths are not relativised' do
          compile!
          output_file(name).should include link % absolute
        end
      end
    end
  end
  
  describe '#preprocess' do
  
    before do
      create_item("#{ name }.html"){ lorem }
    end      
  
    context 'when defined' do
      let :configuration do
        "
        def preprocess *a
          item.identifier = item.identifier.chop + '#{ modified }' + '/'
        end
        "
      end
      let(:modified){ '-woohoo' }
      
      
      it 'can change items identifier' do
        compile!
        File.should_not exist "#{ SITE }/output/#{ name }/index.html"        
        File.should exist "#{ SITE }/output/#{ name + modified }/index.html"        
      end
    end
  end
end
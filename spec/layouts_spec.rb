require 'support/all'
require_lib


describe '=>layouts filter should be based on the file extension if not defined explicitly in Rules' do
  let(:name){ 'testing-layout' }
  prepare_new_item_and_layout!
  let(:metadata){ { 'title' => "Title!" } }
  let(:right_title){ "<title>#{metadata['title']}</title>" }

  context 'layout.slim' do
    let(:layout_ext){ '.slim' };let(:layout){ slim_layout }
    
    it 'should be compiled preoperly' do
      compile!
      output_file(name).should include right_title
    end
  end
  
  context 'layout.erb' do
    let(:layout_ext){ '.erb' };let(:layout){ erb_layout }
    
    it 'should be compiled preoperly' do
      compile!
      output_file(name).should include right_title
    end
  end
  
  context 'layout.erb with slim content' do
    let(:layout_ext){ '.erb' };let(:layout){ slim_layout }
    
    it 'should not be compiled preoperly' do
      compile!
      output_file(name).should_not include 
    end
        
    context 'defined as slim in Rules' do
      before do
        prepend_rules do
          "layout /#{name}/, :slim"
        end
      end
    
      it 'should be compiled preoperly' do
        compile!
        output_file(name).should include right_title
      end
    end  
  end 
end
require 'support/all'
require_lib


def prepend_rules
  TempFiles.prepend "#{SITE}/Rules" do
    yield
  end
end

def read_output name
  File.read "#{SITE}/output/#{name}/index.html"
end

def test_it!
  it 'should be defined just by extension' do  #<<<==
    compile.should == true
    read_output(name).should include "<title>#{metadata['title']}</title>"
  end  
end


describe 'layouts' do
  let(:name){ 'testing-layout' }

  before :each do
    create_layout name, layout_ext do
      layout
    end
    create_item name, item_ext do
      item
    end
    prepend_rules do
      rule
    end
  end

  let(:metadata){ { 'title' => "Title!" } }
  let(:item_ext){ '.html' };let(:item){ lorem metadata }
  let(:rule){ compile_item name }

  context 'slim layout' do
    let(:layout_ext){ '.slim' };let(:layout){ slim_layout }
    
    test_it!  
  end
  
  context 'erb layout' do
    let(:layout_ext){ '.erb' };let(:layout){ erb_layout }
    
    test_it!  
  end  
end
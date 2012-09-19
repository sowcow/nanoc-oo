def create_layout name, ext
  TempFiles.create "#{SITE}/layouts/#{name}#{ext}" do
    yield
  end
end

def create_item name, ext
  TempFiles.create "#{SITE}/content/#{name}#{ext}" do
    yield
  end
end

def slim_layout
"doctype 5
html lang=@item[:lang]
  head
    title = @item[:title]
  body == yield"
end

def erb_layout
"<!doctype html>
<html lang=en>
  <head>
    <title><%= @item[:title] %></title>
  </head>  
  <body>
    <%= yield %>
  </body>  
</html>"
end

def lorem meta={}
  require 'yaml'
  lo = YAML.dump meta
  rem = '<h1>Content!</h1>'
  "#{lo}---\n#{rem}"
end

def compile_item item, lay=nil
  lay ||= item
"compile('/#{item}/'){ layout '#{lay}' }
route('/#{item}/'){'/#{item}/index.html'}"
end

def prepend_rules
  TempFiles.prepend "#{SITE}/Rules" do
    yield
  end
end

def output_file name
  File.read "#{SITE}/output/#{name}/index.html"
end

def compile!
  compile.should == true
end

def prepare_new_item_and_layout!
  before :each do
    create_layout(name, layout_ext){ layout }
    create_item(name, item_ext){ item  }
    prepend_rules{ rule }
  end

  let(:metadata){ { 'title' => "Title!" } }
  let(:item_ext){ '.html' };let(:item){ lorem metadata }
  let(:rule){ compile_item name }
end
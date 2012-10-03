def create_layout name, ext
  TempFiles.create "#{SITE}/layouts/#{name}#{ext}" do
    yield
  end
end

def create_item name, ext=nil
  full_name = ext==nil ? name : "#{name}#{ext}"
  TempFiles.create "#{SITE}/content/#{full_name}" do
    yield
  end
end

def create_class
  text = yield
  name = text[/class(.+?)</, 1].strip.downcase
  TempFiles.create "#{SITE}/lib/classes/#{name}.rb" do
    text
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
  TempFiles.prepend_lines "#{SITE}/Rules" do
    yield
  end
end

def output name
  "#{SITE}/output/#{name}/index.html"
end

def output_file name
  File.read output name
end

def compile!
  compile.should == true
end

def not_compiling!
  compile.should == false
end

def prepare_new_item_and_layout!
  before :each do
    create_layout(name, layout_ext){ layout }
    create_item(name, item_ext){ item  }
    prepend_rules{ rule }
  end

  let(:item_ext){ '.html' };let(:item){ lorem metadata }
  let(:rule){ compile_item name }
end

def stop!
  require 'pry'
  binding.pry
end

def save_png_image file
  require 'chunky_png'
  png = ChunkyPNG::Image.new(16, 16, ChunkyPNG::Color::TRANSPARENT)
  png[1,1] = ChunkyPNG::Color.rgba(10, 20, 30, 128)
  png.save(file, :interlace => true)
end

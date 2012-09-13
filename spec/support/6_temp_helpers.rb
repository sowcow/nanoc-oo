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
"compile('/#{item}/'){ layout lay }
route('/#{item}/'){'/#{item}/index.html'}"
end
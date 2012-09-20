require 'support/all'
require_lib


describe '=>items configuration through classes', focus do

  before do
    create_item("#{name}.html"){ lorem }
    TempFiles.create "#{SITE}/lib/classes/#{name}.rb" do
"
class TestingPage < Page
  GOOD_ID = Regexp.new Regexp.escape '/#{name}/'
  
  def route
    '/#{new_route}/index.html'
  end
end"    
    end
  end

  let(:name){ 'teting-items-and-classes' }
  let(:new_route){ 'test-route-changed.html' }
  

  context 'routes' do
    specify 'should be configured properly' do
      compile!
      breakpoint binding

      File.should_not exist "#{SITE}/output/#{name}/index.html"
      File.should exist "#{SITE}/output/#{new_route}/index.html"
    end
  end
end
require 'support/all'
require_lib


describe '=>items configuration through classes' do

  before do
    create_item("#{name}.html"){ lorem }
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

      specify 'should work for .html files' do
        compile!
        File.should exist "#{SITE}/output/#{name}/index.html"
      end
    end    
  
    it 'should be configured properly' do
      compile!

      File.should_not exist "#{SITE}/output/#{name}/index.html"
      File.should exist     "#{SITE}/output/#{route}/index.html"
    end 
  end
end
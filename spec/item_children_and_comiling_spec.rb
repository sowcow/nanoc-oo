require 'support/all'
require_lib


describe 'items compiling guided by children' do
  before do
    create_class do
      "
        class Test < Page
          GOOD_ID = //
        end
      "
    end
  end

  context 'just root item' do
    before do
      create_item('index.html'){ lorem }
    end

    it 'works' do
      compile!
      File.should exist "#{SITE}/output/index.html"
    end
  end

  context 'just non-root item' do
    let(:name){ 'non-root-item' }
    before do
      create_item("#{name}.html"){ lorem }
    end

    it 'works' do
      compile!
      File.should exist output name
    end
  end

  context 'one deep seated item' do

    before(:each){ pending }

    let(:name){ 'deep/seated/item' }
    before do
      create_item("#{name}.html"){ lorem }
    end

    it 'works' do
      compile!
      File.should exist output name
    end
  end
end
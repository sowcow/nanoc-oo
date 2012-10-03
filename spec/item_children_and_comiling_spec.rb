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
end
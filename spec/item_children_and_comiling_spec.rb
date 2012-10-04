require 'support/all'
require_lib

def chdir name
  Dir.mkdir name
  Dir.chdir name do
    yield
  end
end

def write file, text=lorem
  File.write file, text
end



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

    let(:name){ 'deep/seated/item' }
    before do
      create_item("#{name}.html"){ lorem }
    end

    it 'works' do
      compile!
      File.should exist output name
    end
  end

  context 'small tree of items with index.html files' do

    let(:name){'some-temp-test-dir'}
    let(:dir){"#{SITE}/content/#{name}"}
    let(:text){ lorem }
    after :all do
      rm_rf dir
    end
    before :all do
      chdir dir do
        write 'index.html'
        write 'file1.html'
        chdir 'dir' do
          write 'index.html'
          write 'file2.html'
          write 'file3.html'
        end
      end
    end

    it 'compiles nested files' do
      compile!
      File.should exist output "#{name}/file1"
      File.should exist output "#{name}/dir/file2"
      File.should exist output "#{name}/dir/file3"
    end

    it 'compiles index items' do
      compile!
      File.should exist output name
      File.should exist output "#{name}/dir"
    end
  end  
end
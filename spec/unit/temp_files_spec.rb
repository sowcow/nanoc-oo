require 'support/all'
require_lib

describe TempFiles do
  after(:each) do
    TempFiles.purge
  end
  
  context 'file modifications:' do
    let(:name){ 'temp-file-testing-TempFiles.txt' }
    let(:text){ 'text for file' }    
    let(:fragment){ 'fragment to prepend' }    
    
    before do
      TempFiles.create name do
        text
      end    
    end
    
    context '#prepend' do   
      it 'should prepend file with text' do
        TempFiles.prepend name do
          fragment
        end
        File.read(name).should == "#{fragment}#{text}"
        TempFiles.revert
        File.read(name).should == text
      end
    end
  
    context '#prepend_lines' do

      it 'should prepend file with lines and \n if needed' do
        TempFiles.prepend_lines name do
          fragment
        end
        File.read(name).should == "#{fragment}\n#{text}"
        TempFiles.revert
        File.read(name).should == text

        TempFiles.prepend_lines name do
          fragment + "\n"
        end
        File.read(name).should == "#{fragment}\n#{text}"
        TempFiles.revert
        File.read(name).should == text
      end
    end  
  end
   
  context '#create' do
    let(:name){ 'temp-file-testing-TempFiles.txt' }
    let(:text){ 'text for file' }

    let(:test_dir){ 'test-temp-dir' }
    let(:nested){ "#{test_dir}/nested/file.txt" }
    after :each do
      rm_rf test_dir
    end

    it 'should create file' do
      TempFiles.create name do
        text
      end
      File.should exist name
      File.read(name).should == text
    end

    it 'creates deeply seated files' do
      TempFiles.create nested, &->{ lorem }
      File.should exist nested
    end
  end
  
  context '#purge' do
    let(:dir){ 'temp-test-dir-TempFiles' }
    let(:count){ 10 }

    before do
      Dir.mkdir dir
    end
    
    after do
      rm_rf dir
    end

    it 'should remove all created files' do
      2.times do
        count.times do |name|
          TempFiles.create("#{dir}/#{name}"){ name }
        end
        Dir["#{dir}/**"].count.should == count
        TempFiles.purge
        Dir["#{dir}/**"].count.should == 0
      end  
    end
    
    it 'should not raise errors :)' do
      count.times do |name|
        TempFiles.create("#{dir}/#{name}"){ name }
      end
      Dir["#{dir}/**"].count.should == count
      rm_rf dir
      expect { TempFiles.purge }.to_not raise_error
    end    
  end  
end
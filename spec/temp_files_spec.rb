require 'support/all'
require_lib

describe TempFiles do
  after(:each) do
    TempFiles.purge
  end
  
  context '#create' do
    let(:name){ 'temp-file-testing-TempFiles.txt' }
    let(:text){ 'text for file' }

    it 'should create file' do
      TempFiles.create name do
        text
      end
      File.should exist name
      File.read(name).should == text
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
  end  
end
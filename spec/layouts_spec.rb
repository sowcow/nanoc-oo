require 'support/all'
require_lib


describe '=> layouts' do
  let(:name){ 'testing-layout' }
  prepare_new_item_and_layout!

  context 'slim layout' do
    let(:layout_ext){ '.slim' };let(:layout){ slim_layout }
    
    it 'should be compiled preoperly' do
      compile!
      output_file(name).should include "<title>#{metadata['title']}</title>"
    end
  end
  
  context 'erb layout' do
    let(:layout_ext){ '.erb' };let(:layout){ erb_layout }
    
    it 'should be compiled preoperly' do
      compile!
      output_file(name).should include "<title>#{metadata['title']}</title>"
    end
  end  
end
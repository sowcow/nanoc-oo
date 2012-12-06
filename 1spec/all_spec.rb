require 'nanoc-oo'

def join *a
  File.join *a
end
def read *a
  File.read *a
end

describe NanocOO do
  include FileUtils

  let(:temp){ 'temp' }
  let(:site){ "#{temp}/site" }
  after :all do
  	rm_rf temp
  end

  it 'creates site with nanoc' do # stateful
  	`nanoc-oo #{site}`
  	File.should exist join(site,'Rules')
  end

  describe 'created site' do # stateful
  	it 'is wrapped' do
      read(join(site,'Rules')).should == read(join(NanocOO.wrapper,'Rules'))
  	end

  	context 'terminal outputs' do
  	  specify 'nanoc output'
  	  specify 'wrapping info'
  	  specify '--help?'
    end if false
  end
end
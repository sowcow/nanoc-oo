require 'nanoc-oo'

describe NanocOO do
  include FileUtils

  let(:temp){ 'temp' }
  let(:site){ "#{temp}/site" }
  before :each do
    rm_rf temp
  end  
  after :each do
    rm_rf temp
  end

  it 'creates site with nanoc' do
    `nanoc-oo #{site}`
    File.should exist join(site,'Rules')
    Dir[join(site,'content')].count.should > 0
  end

  it 'creates site with nanoc (w/o cli)' do
    NanocOO.create_site site
    File.should exist join(site,'Rules')
    Dir[join(site,'content')].count.should > 0
  end

  it 'creates site without content if --blank specified' do
    `nanoc-oo #{site} --blank`
    File.should exist join(site,'Rules')
    Dir[join(site,'content')].count.should == 0
  end

  describe 'created site' do
    before do
      `nanoc-oo #{site}`
    end

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

BEGIN{
  def join *a
    File.join *a
  end
  def read *a
    File.read *a
  end
}
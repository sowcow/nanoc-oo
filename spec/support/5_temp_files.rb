RSpec.configure do |config|
  config.after(:each) do
    TempFiles.revert
    TempFiles.purge
  end
end

class TempFiles
  @files = []
  @prepends = []
  
  
class << self
  def create file
    @files << file
    File.write(file, yield)
  end
  
  def purge
    @files.each do |file|
      File.delete file if File.exist? file
    end
    @files = []
  end
  
  def prepend file
    fragment = yield
    text = File.read(file)
    File.write(file, "#{fragment}#{text}")
    @prepends << [file, fragment]
  end
  
  def prepend_lines file
    prepend(file){ yield.chomp + "\n" }
  end  
  
  def revert
    @prepends.each do |file, fragment|
      text = File.read(file)
      File.write file, text.sub(fragment, '')
    end
    @prepends = []    
  end
end  
end
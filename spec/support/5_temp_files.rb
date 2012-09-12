RSpec.configure do |config|
  config.after(:each) do
    TempFiles.purge
  end
end

class TempFiles
  @files = []
  
  def self.create file
    @files << file
    File.write(file, yield)
  end
  
  def self.purge
    @files.each do |file|
      File.delete file if File.exist? file
    end
    @files = []
  end
end
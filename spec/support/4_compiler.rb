def compile
  Dir.chdir SITE do
    rm_rf 'output'
    `nanoc compile`
  end
  crash = File.exist? "#{SITE}/crash.log"
  FileUtils.cp "#{SITE}/crash.log", 'crash.log' if crash
  not crash
end

RSpec.configure do |config|
  config.before(:all) do
    File.delete 'crash.log' if File.exist? 'crash.log'
    compile
  end
end
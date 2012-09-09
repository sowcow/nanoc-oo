def compile site=SITE
  Dir.chdir site do
    `nanoc compile`
  end
end

RSpec.configure do |config|
  config.before(:all) do
    compile
  end
end
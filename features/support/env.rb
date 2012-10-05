require 'aruba/cucumber'

at_exit do
  FileUtils.rm_rf 'tmp'
end


__END__
 || undefined method 'feature' for ...ScenarioOutline...reporting.rb:101
 \/ 
 ENV['ARUBA_REPORT_DIR'] = 'doc_features'
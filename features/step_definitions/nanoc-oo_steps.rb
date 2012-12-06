Given 'I have a wrapped default nanoc site' do
  step '$ nanoc-oo site'
  step 'I cd to "site"'  
end

Given 'I have a blank wrapped nanoc site' do
  step '$ nanoc-oo site --blank'
  step 'I cd to "site"'  
end
When 'I copy the nanoc-oo wrapper here' do
  copy_all from: 'wrapper/.', to: current_dir
end

Given 'I have a wrapped default nanoc site' do
  step 'I have a default nanoc site'
  step 'I copy the nanoc-oo wrapper here'
end

Given 'I have a blank wrapped nanoc site' do
  step 'I have a wrapped default nanoc site'
  step 'I remove the file "content/index.html"'
  step 'I remove the file "content/stylesheet.css"'
end
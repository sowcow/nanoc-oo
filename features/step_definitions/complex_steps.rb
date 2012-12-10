def make_table array
  table array.map { |str| [str] }
end

Step 'the folowing are * files:...' do |group, files|
  (@groups ||= {})[group] = files.lines.map(&:strip).reject &:empty?
end

Step 'the * files should *exist' do |group, nt| # nt~not
  step "the following files should #{nt}exist:", make_table(@groups[group])
end

Step '(the )?*( files)? are the only (ones|files) in( the)? "*" directory' do |group, dir|
  really = nil
  in_current_dir do
    really = Dir[File.join(dir,'**/**')].to_a
  end 
  ideal = @groups[group]
  extra = really - ideal
  missing = ideal - really
  step 'the following files should exist:', make_table(missing)
  step 'the following files should not exist:', make_table(extra)
end

Step 'the following empty files exist:' do |table|
  table.raw.map{|x|x[0]}.each do |file|
    step 'an empty file named "%s"' % file
  end
  # table is a Cucumber::Ast::Table
  #pending # express the regexp above with the code you wish you had
end


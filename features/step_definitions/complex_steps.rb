def make_table array
  table array.map { |str| [str] }
end

Step 'the folowing are * files:...' do |group, files|
  (@groups ||= {})[group] = files.lines.map &:strip
end

Step 'the * files should *exist' do |group, nt| # nt~not
  step "the following files should #{nt}exist:", make_table(@groups[group])
end

Step 'the * files are the only ones in the "*" directory' do |group, dir|
  in_current_dir do
    really = Dir[File.join(dir,'**/**')].to_a
  end 
  ideal = @groups[group]
  extra = really - ideal
  missing = ideal - really
  step 'the following files should exist:', make_table(missing)
  step 'the following files should not exist:', make_table(extra)
end
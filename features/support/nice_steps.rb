def full_line line
  /^#{line}$/
end

def regex str
  full_line str.gsub(/\*/, '(.*?)')   #(/(?<!\\)\*/, '(.*?)')
end

def Step step, &block
  When regex(step), &block
end
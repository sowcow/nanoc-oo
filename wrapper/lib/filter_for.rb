module FilterFor
  extend self
  KNOWN_FILTERS = {}
  
  def [] file
    filter_ext File.extname file
  end
  
  private
  def filter_ext ext
    ext = ext.sub(/^\./,'')
    KNOWN_FILTERS[ext] or ext.to_sym
  end
end
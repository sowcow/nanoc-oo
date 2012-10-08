# tricky way to register .example files as cucumber features

DEFAULT = /\*\.feature$/
MODIFIED = '*.example'

class Dir
  class << self
    alias _super []
  end

  def self.[] mask
    return _super(mask) if mask !~ DEFAULT

    _super(mask).to_a + _super(mask.sub(DEFAULT, MODIFIED)).to_a
  end
end
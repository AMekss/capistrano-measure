require 'stringio'
require 'logger'

class StringLogger < Logger
  def initialize
    @strio = StringIO.new
    super @strio
  end

  def to_s
    @strio.string
  end
end

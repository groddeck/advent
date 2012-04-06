require_relative 'breakable'
require_relative 'movable'

class Vase < WorldObject
  include Breakable
  include Movable
  
  def initialize(opts={})
    super(opts.merge(name: 'vase'))
  end
end

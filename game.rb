require_relative 'world'
require_relative 'player'
require_relative 'prompt'
require_relative 'vase'
require_relative 'movable_object'
require_relative 'locked_door'

class Game
  attr_accessor :player, :world
  
  def initialize(start_room=nil)
    @world = World.new
    @player = Player.new(container: @world, name: 'self')
    @world.contents << @player
  end

  def current_room
    @player.container
  end
end

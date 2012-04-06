require_relative 'world'
require_relative 'player'

class Game
  attr_accessor :player, :world
  
  def initialize
    @world = World.new
    @player = Player.new(container: @world, name: 'self')
    @world.contents << @player
  end
end

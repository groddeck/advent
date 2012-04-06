require_relative 'prompt'
require_relative 'vase'
require_relative 'game'

class Advent < Game
  def start
    @world.contents << WorldObject.new(container: @world, name: 'rock')
    @world.contents << WorldObject.new(container: @world, name: 'river')
    @world.contents << WorldObject.new(container: @world, name: 'tree')
    @world.contents << WorldObject.new(container: @world, name: 'shed')
    @world.contents << Vase.new(container: @world, long_description: 'A beautiful antique vase.  It looks fragile.')

    Prompt.new(self).prompt
  end
end

advent = Advent.new
advent.start

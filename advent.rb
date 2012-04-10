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

    # Rooms
    ## Shed
    house = Room.new
    @world.exit(:north, house, :south)
    ## South of Road
    south_of_road = Room.new
    @world.exit(:south, south_of_road, :north)
    ## Grate
    grate = Room.new
    south_of_road.exit(:south, grate, :north)
    ## Depression
    depression = Room.new
    grate.exit(:down, depression, :up)
    ## Flotsam
    flotsam = Room.new
    depression.exit(:east, flotsam, :west)
    ## Lots more
    ## ...

    Prompt.new(self).prompt
  end
end

advent = Advent.new
advent.start

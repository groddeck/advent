require_relative 'prompt'
require_relative 'vase'
require_relative 'game'
require_relative 'movable_object'

class Advent < Game
  def start
    @world.contents << WorldObject.new(container: @world, name: 'rock')
    @world.contents << WorldObject.new(container: @world, name: 'river')
    @world.contents << WorldObject.new(container: @world, name: 'tree')
    @world.contents << WorldObject.new(container: @world, name: 'shed')
    @world.contents << Vase.new(container: @world, long_description: 'A beautiful antique vase.  It looks fragile.')

    # Rooms
    ## Building
    building = Room.new(
      short_description: 'Inside Building',
      long_description: 'You are inside a building, a well house for a large spring.')
    @world.exit(:east, building, :west)
    # There is a shiny brass lamp nearby.
    # You can also see a set of keys, some tasty food and a small bottle (in which is some bottled water) here.
    building_stuff = [
      lamp = MovableObject.new(name: 'lamp'),
      keys = MovableObject.new(name: 'keys'),
      food = MovableObject.new(name: 'food'),
      bottle = MovableObject.new(name: 'bottle')
    ]
    building_stuff.map { |obj| obj.move(building) }
    ## Valley
    valley = Room.new(
      short_description: 'In A Valley',
      long_description: 'You are in a valley in the forest beside a stream tumbling along a rocky bed.')
    @world.exit(:south, valley, :north)
    ## Slit
    slit = Room.new(
      short_description: 'At Slit In Streambed',
      long_description: 'At your feet all the water of the stream splashes into a 2-inch slit in the rock. Downstream the streambed is bare rock.')
    valley.exit(:south, slit, :north)
    ## Grate
    grate = Room.new(
      short_description: 'Outside Grate',
      long_description: 'You are in a 20-foot depression floored with bare dirt. Set into the dirt is a strong steel grate mounted in concrete. A dry streambed leads into the depression.')
    valley.exit(:south, grate, :north)
    # Below
    below = Room.new(
      short_description: 'Below the Grate',
      long_description: 'You are in a small chamber beneath a 3x3 steel grate to the surface. A low crawl over cobbles leads inward to the west.')
    grate.blocked_exit(:down, below, :up, "grate")
    ## Flotsam
    flotsam = Room.new(short_description: '', long_description: '')
    grate.exit(:east, flotsam, :west)
    ## Lots more
    ## ...

    Prompt.new(self).prompt
  end
end

advent = Advent.new
advent.world.short_description = 'At End Of Road'
advent.world.long_description = 
  'You are standing at the end of a road before a small brick building. Around you is a forest. A small stream flows out of the building and down a gully.'
advent.world.look
advent.start

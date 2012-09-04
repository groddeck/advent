require_relative 'game'

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
    locked_grate = LockedDoor.new(name: "grate", key: keys)
    grate.blocked_exit(:down, below, :up, locked_grate)
    ## Cobbles
    cobbles = Room.new(short_description: 'In Cobble Crawl',
      long_description: 'You are crawling over cobbles in a low passage. There is a dim light at the east end of the passage.')
    #      There is a small wicker cage discarded nearby.
    below.exit(:west, cobbles, :east)
    wicker_cage = MovableObject.new(name: 'cage', long_description: "It's a small wicker cage.")
    wicker_cage.move(cobbles)
    ## Lots more
    ## ...
    ## Debris
    debris = Room.new(short_description: 'In Debris Room',
      long_description: 'You are in a debris room filled with stuff washed in from the surface. A low wide passage with cobbles becomes plugged with mud and debris here, but an awkward canyon leads upward and west.'
    )
    cobbles.exit(:west, debris, :east)
    # A note on the wall says, "Magic word XYZZY."
    note = WorldObject.new(name: 'note', room_description: 'A note on the wall says, "Magic word XYZZY."', long_description: 'The note says "Magic word XYZZY".')
    debris.contents << note
    # A three foot black rod with a rusty star on one end lies nearby.
    rod = MovableObject.new(name: 'rod', room_description: 'A three foot black rod with a rusty star on one end lies nearby.', long_description: "It's a three foot black rod with a rusty star on an end.")
    rod.move(debris)

    Prompt.new(self).prompt
  end
end

advent = Advent.new
advent.world.short_description = 'At End Of Road'
advent.world.long_description = 
  'You are standing at the end of a road before a small brick building. Around you is a forest. A small stream flows out of the building and down a gully.'
advent.world.look
advent.start

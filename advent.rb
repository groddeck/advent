require_relative 'game'

class Advent < Game

  class Cage < MovableObject
    include Container
  end

  class AliveObject < MovableObject
    ## An AliveObject is willful and thoughtful - is a creature, human, etc.
    ## It will object to being hit, taken and some other object, so it changes
    ## the defaults associated with inanimate objects.
    def take(callbacks = {})
      ## First allow self to decide if it wants to be taken.
      if take?
        super(callbacks)
      else
        puts refuse_taking_message
      end
    end

    def take?
      false
    end

    def refuse_taking_message
      refuse_action_against_message
    end

    def refuse_action_against_message
      "The #{@name} wouldn't like that."
    end

    def hit
      if hit?
        super
      else
        puts refuse_hitting_message
      end
    end

    def hit?
      false
    end

    def refuse_hitting_message
      refuse_action_against_message
    end
  end

  class Bird < AliveObject
    def take?
      return !has_cage.empty? && has_rod.empty?
    end

    def has_rod
      @game.player.contents.select {|obj| obj.name == 'rod'}
    end

    def has_cage
      @game.player.contents.select {|obj| obj.name == 'cage'}
    end

    def refuse_taking_message
      if has_rod
        "The bird was unafraid when you entered, but as you approach it becomes disturbed and you cannot catch it."
      else
        "You can catch the bird, but you cannot carry it."
      end
    end

    def drop
      ## Seek and destroy snake.
      has_snake = @game.current_room.contents.select {|obj| obj.name == 'snake'}
      if !has_snake.empty?
        snake = has_snake.first
        snake.remove
        puts "The little bird attacks the green snake, and in an astounding flurry drives the snake away."
      end
    end
  end

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
    slit.exit(:south, grate, :north)

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
    wicker_cage = Cage.new(name: 'cage', long_description: "It's a small wicker cage.")
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

    ## Canyon
    canyon = Room.new(short_description: 'Sloping E/W Canyon',
      long_description: 'You are in an awkward sloping east/west canyon.'
    )
      debris.exit(:west, canyon, :east)

    ## Orange River Chamber
    orange_river_chamber = Room.new(short_description: 'Orange River Chamber',
      long_description: 'You are in a splendid chamber thirty feet high. The walls are frozen rivers of orange stone. An awkward canyon and a good passage exit from east and west sides of the chamber.'
    )
    canyon.exit(:west, orange_river_chamber, :east)
    bird = Bird.new(game: self, name: 'bird', room_description: 'A cheerful little bird is sitting here singing.', long_description: 'The little bird looks unhappy in the cage.')
    bird.move(orange_river_chamber)
    #respect a taken object's wishes. bird won't be held without cage, and shuns the rod.

    ## Edge of Pit
    edge = Room.new(
      short_description: 'At Top of Small Pit',
      long_description: <<-eos
At your feet is a small pit breathing traces of white mist. A west passage ends here except for a small crack leading on.

Rough stone steps lead down the pit.
eos
    )
    orange_river_chamber.exit(:west, edge, :east)

    ## Hall of Mists
    mists = Room.new(
      short_description: 'In Hall of Mists',
      long_description: <<-eos
You are at one end of a vast hall stretching forward out of sight to the west. There are openings to either side. Nearby, a wide stone staircase leads downward. The hall is filled with wisps of white mist swaying to and fro almost as if alive. A cold wind blows up the staircase. There is a passage at the top of a dome behind you.

Rough stone steps lead up the dome.
eos
    )
    edge.exit(:down, mists, :up)

    ## East of Fissure
    east_of_fissure = Room.new(
      short_description: 'On East Bank of Fissure',
      long_description: 'You are on the east bank of a fissure slicing clear across the hall. The mist is quite thick here, and the fissure is too wide to jump.'
    )
    mists.exit(:west, east_of_fissure, :east)

    ## Hall
    hall = Room.new(
      short_description: 'Hall of the Mountain King',
      long_description: 'You are in the hall of the mountain king, with passages off in all directions.'
    )
    mists.exit(:down, hall, :up)
    snake = AliveObject.new(
      name: 'snake',
      room_description: 'A huge green fierce snake bars the way!',
      long_description: 'I wouldn\'t mess with it if I were you.'
    )
    snake.move(hall)

    Prompt.new(self).prompt
  end
end

advent = Advent.new
advent.world.short_description = 'At End Of Road'
advent.world.long_description = 
  'You are standing at the end of a road before a small brick building. Around you is a forest. A small stream flows out of the building and down a gully.'
advent.world.look
advent.start

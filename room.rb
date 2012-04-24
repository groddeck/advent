require_relative 'world_object'
require_relative 'container'
require_relative 'exit'

class Room < WorldObject
  include Container

  attr_accessor :exits

  #room name
  #room desc
  #exits? not always. can be in room descr if desired.
  #open object with displayable stuff in the room
  #a list of other objects also in the room, by name
  def look
    puts "*#{@short_description}*"
    puts "#{@long_description}"
    puts
    to_show = contents.reject{|o| o.name == 'self'}
    if not to_show.empty?
      print "You can see "
      to_show.each do |obj|
        print "and " if obj == to_show.last && obj != to_show.first
        print "#{obj.name} "
      end
      puts "here."
    end
  end

  def exit(dir_symbol, room, rev_symbol=nil)
    blocked_exit(dir_symbol, room, rev_symbol, nil)
  end

  def blocked_exit(dir_symbol, room, rev_symbol, obstruction)
    @exits = {} unless @exits
    @exits[dir_symbol] = Exit.new(room, obstruction)
    if(rev_symbol)
      room.exit(rev_symbol, self)
    end
  end
end

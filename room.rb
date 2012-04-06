require_relative 'world_object'
require_relative 'container'

class Room < WorldObject
  include Container

  #room desc
  #exits
  #open object with displayable stuff in the room
  #a list of other objects also in the room, by name
  def look
    puts "Describe the room, the exits, nested containers in the room and a list of other objects in the room."
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
end

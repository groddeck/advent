require_relative 'world_object'
require_relative 'container'

class Player < WorldObject
  include Container

  def look
    puts "Lookin' gooood!"
  end

  def inventory
    puts "You are carrying"
    contents.each do |o|
      puts "\t#{o.name}"
    end
    if contents.empty?
      puts "nothing"
    end
  end
end

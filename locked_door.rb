require_relative 'world_object'

class LockedDoor < WorldObject

  attr_accessor :key, :locked

  def initialize(opts={})
    super(opts)
    @key = opts[:key]
    @locked = true
  end

  def pass
    if @locked
      puts 'It seems to be locked.'
      return false
    else
      return true
    end
  end

  def unlock
    if @locked
      @locked = false
      puts "You unlock #{@name}."
    else
      puts "That's unlocked at the moment."
    end
  end
end

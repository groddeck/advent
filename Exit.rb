class Exit
  attr_accessor :room
  attr_accessor :obstruction

  def initialize(room, obstruction=nil)
    @room = room
    @obstruction = obstruction
  end
end

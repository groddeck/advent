class WorldObject
  
  attr_accessor :name, :long_description, :short_description
  
  def initialize(opts={})
    @name = opts[:name]
    @long_description = opts[:long_description]
    @short_description = opts[:short_description]
  end

end

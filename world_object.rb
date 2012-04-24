class WorldObject

  attr_accessor :name, :long_description, :short_description, :container
  
  def initialize(opts={})
    @name = opts[:name]
    @long_description = opts[:long_description]
    @short_description = opts[:short_description]
    @container = opts[:container]
  end

  def remove
    if @container
      # puts "Removing #{self.name} from container: #{container}"
      # puts "BEFORE: #{container.contents.size}"
      self.container.contents.reject! {|obj| obj == self} if self.container
      # puts "AFTER: #{container.contents.size}"
    end
  end

  def move(target)
    remove
    self.container = target
    target.contents << self
  end

  def look
    if @long_description
      puts "#{@long_description}"
    else
      puts "You see nothing remarkable about #{@name}"
    end
  end
end

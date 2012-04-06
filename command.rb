require_relative 'action'
require_relative 'world_object'

class Command

  attr_accessor :action
  attr_accessor :direct_object
  attr_accessor :world, :game

  def self.create(tokens, lexicon, game)
    command = Command.new
    action_name = tokens[0]
    action = Action.new(action_name, lexicon)
    command.action = action
    command.game = game
    world = command.world = game.world
    if object_name = tokens[1]
      # puts ">>> object_name: [#{object_name}]"
      default_object = WorldObject.new(name: "Unmatched object called: [#{object_name}]")
      # puts ">>> default_object: [#{default_object}], [#{default_object.name}]"
      # puts ">>> world.select with name: [#{world.select {|o| o.name == object_name}}]"
      direct_object = (world.contents.select {|o| o.name == object_name}).first || WorldObject.new(name: "Unmatched object called: [#{object_name}]")
      # puts ">>> matched direct_object: [#{direct_object}]"
      command.direct_object = direct_object
    end
    return command
  end

  def execute
    # puts action
    puts "running command - action: #{@action.text} #{@direct_object.name if @direct_object}"
    @action.perform @game, @direct_object
  end

  def corrupt?
    @action.corrupt
  end

end

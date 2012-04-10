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
    command.world = game.world
    world = command.world
    
    if object_name = tokens[1]
      #when trying to match objects, search the room the player is in, and open containers in the room...
      visible = []
      visible << game.current_room.contents
      visible.flatten!
      direct_object = nil
      visible.each do |vis|
        if vis.name == object_name
          direct_object = vis
          break
        end
        if vis.is_a? Container
          # TODO: logic for deciding if container is closable+open/unclosable/transparent
          # ... but for now just allow things to be seen regardless.
          vis.contents.each do |obj|
            if obj.name == object_name
              direct_object = obj
            end
            if direct_object
              break
            end
          end
        end
      end
      # puts ">>> object_name: [#{object_name}]"
      # default_object = WorldObject.new(name: "Unmatched object called: [#{object_name}]") #hronir
      # puts ">>> default_object: [#{default_object}], [#{default_object.name}]"
      # puts ">>> world.select with name: [#{world.select {|o| o.name == object_name}}]"
      # puts ">>> matched direct_object: [#{direct_object}]"
      if %w(north south east west up down ne se sw nw).include? object_name
        direct_object = WorldObject.new(name: object_name)
      end
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

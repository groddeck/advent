require_relative 'command'

class Prompt

  def initialize(game, world=[])
    @game = game
    @world = world
  end
  
  def prompt
    print "\n>"
    input = gets.strip
    print "\n"
    command = parse input
    begin
      command.execute unless input.empty?
    rescue Exception => e
      if command.action.text == 'exit'
        exit
      end
    end
    prompt
  end

  def parse(input)
    Command.create(input.split, [], @game)
  end

end

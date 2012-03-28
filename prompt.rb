require_relative 'command'

class Prompt

  def initialize
  end
  
  def prompt
    print "Input text: "
    input = gets.strip
    puts "You said: #{input}\n"
    command = parse input
    command.execute
    prompt
  end

  def parse(input)
    Command.create(input.split, [], [])
  end

end

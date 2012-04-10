class Action
  
  attr_accessor :text
  attr_accessor :corrupt
  
  STD_LEXICON = [
    #special game commands
    {'term' => 'exit', 'proc' => Proc.new {
      puts 'Exiting game...'
      exit
      }
    },
    {
      'term' => 'save', 'proc' => Proc.new {
        puts 'File to save as...?'
        save_file_name = gets
        puts "Save to #{save_file_name}"
        puts "SOCIALLY AWKWARD SAVE MODULE:"
        puts 'Tries to save...'
        puts '...Doesn\'t really save.'
      }
    },

    {
      'term' => 'hit', 'proc' => Proc.new { |world, dir_obj|
        puts "ACTION: exec hit verb upon direct-object: [#{dir_obj.name}]" if dir_obj
        begin
          dir_obj.hit
        rescue Exception => e
          puts "Hitting #{dir_obj.name if dir_obj} didn't have any effect."
        end
      }
    },
    {
      'term' => 'look', 'proc' => Proc.new { |game, dir_obj| 
        # puts "Looking at #{dir_obj}"
        puts ">>> game.player.container: #{game.player.container}"
        dir_obj = game.player.container unless dir_obj
        begin
          dir_obj.look
        rescue Exception => e
          puts "You don't see any such thing."
        end
      }
    },
    {
      'term' => 'inventory', 'proc' => Proc.new { |game, dir_obj|
        game.player.inventory
      }
    },
    {
      'term' => 'drop', 'proc' => Proc.new { |game, dir_obj|
        puts "exec drop verb: #{dir_obj.name}"
        begin
          if game.player.contents.include? dir_obj
            dir_obj.remove
            dir_obj.container = game.current_room
            game.current_room.contents << dir_obj
          else
            puts "You don't have that"
          end
        rescue Exception => e
          puts "You can't do that."
        end
      }
    },
    {
      'term' => 'take', 'proc' => Proc.new { |game, dir_obj|
        begin
          dir_obj.take
          dir_obj.container = game.player
          game.player.contents << dir_obj
        rescue Exception => e
          puts "You can't do that."
        end
      }
    },
    {
      'term' => 'go', 'proc' => Proc.new { |game, dir_obj|
        # puts "game.room exits: #{game.current_room.exits}"
        puts ">>> direction: #{dir_obj}"
        target = game.current_room.exits[dir_obj.name.to_sym]
        puts ">>> room that is #{dir_obj} of here: #{target}"
        game.player.remove
        target.contents << game.player
        game.player.container = target
        target.look
      }
    }
  ]

  def initialize(text, lexicon)
    lexicon += STD_LEXICON
    # puts lexicon.inspect
    @corrupt = true
    @text = text
    @verb = lexicon.select {|entry| entry['term'] == text}.first
    @corrupt = false if lexicon.map { |entry| entry['term'] }.include? text
  end

  def perform(game, args=nil)
    @verb['proc'].call game, args if @verb
  end
end

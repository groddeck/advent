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
        # puts ">>> game.player.container: #{game.player.container}"
        dir_obj = game.player.container unless dir_obj
        begin
          dir_obj.look
        rescue Exception => e
          puts "You can't see any such thing."
        end
      }
    },
    {
      'term' => 'inventory', 'proc' => Proc.new { |game, dir_obj|
        game.player.inventory
      },
      'synonyms' => 'i'
    },
    {
      'term' => 'drop', 'proc' => Proc.new { |game, dir_obj|
        puts "exec drop verb: #{dir_obj.name}"
        begin
          if game.player.contents.include? dir_obj
            dir_obj.remove
            dir_obj.container = game.current_room
            game.current_room.contents << dir_obj
            dir_obj.drop
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
        if game.player.contents.include? dir_obj
          puts "You already have that."
          return
        end
        begin
          dir_obj.take(success: 
            lambda do
              dir_obj.container = game.player
              game.player.contents << dir_obj
            end
          )
        rescue Exception => e
          puts "You can't do that."
        end
      }
    },
    {
      'term' => 'go', 'proc' => Proc.new { |game, dir_obj|
        # puts "game.room exits: #{game.current_room.exits}"
        exit = game.current_room.exits[dir_obj.name.to_sym] if dir_obj
        if exit
          if !exit.obstruction || exit.obstruction.pass
            target = exit.room
            puts ">>> room that is #{dir_obj} of here: #{target}"
            game.player.remove
            target.contents << game.player
            game.player.container = target
            target.look
          end
        else
          puts "You can't go that way."
        end
      }
    },
    {
      'term' => 'unlock', 'proc' => Proc.new { |game, dir_obj|
        dir_obj.unlock
      }
    }
  ]

  def initialize(text, lexicon)
    lexicon += STD_LEXICON
    directions =
      [
        ['north', 'n'], 
        ['northeast', 'ne'], 
        ['east', 'e'], 
        ['southeast', 'se'], 
        ['south', 's'], 
        ['southwest', 'sw'], 
        ['west', 'sw'], 
        ['west', 'w'], 
        ['northwest', 'nw'], 
        ['up', 'u'], ['down', 'd']
      ]
    go_verb = (lexicon.select { |v| v['term'] == 'go' }).first
    directions.each do |pair|
      lexicon <<
        {
          'term' => pair[0], 'proc' => Proc.new{ |game|
            go_verb['proc'].call game, WorldObject.new(name: pair[0])
          }
        }
      lexicon <<
        {
          'term' => pair[1], 'proc' => Proc.new{ |game|
            go_verb['proc'].call game, WorldObject.new(name: pair[0])
          }
        }
    end
    # puts lexicon.inspect
    @corrupt = true
    @text = text
    @verb = lexicon.select {|entry| ([entry['term']]+[entry['synonyms']]).include? text}.first
    @corrupt = false if lexicon.map { |entry| entry['term'] }.include? text
  end

  def perform(game, args=nil)
    @verb['proc'].call game, args if @verb
  end
end

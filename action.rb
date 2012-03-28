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
        puts 'Tries to save...'
        puts '...Doesn\'t really save.'
      }
    },

    {
      'term' => 'hit', 'proc' => Proc.new { |dir_obj|
        puts "ACTION: exec hit verb upon direct-object: [#{dir_obj.name}]"
        begin
          dir_obj.hit
        rescue Exception => e
          
        end
      }
    },
    {'term' => 'take', 'proc' => Proc.new {puts 'exec take verb'}}
  ]

  def initialize(text, lexicon)
    lexicon += STD_LEXICON
    puts lexicon.inspect
    @corrupt = true
    @text = text
    @verb = lexicon.select {|entry| entry['term'] == text}.first
    @corrupt = false if lexicon.map { |entry| entry['term'] }.include? text
  end

  def perform(args=nil)
    @verb['proc'].call args
  end
end

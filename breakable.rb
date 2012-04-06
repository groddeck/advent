module Breakable
  
  def hit
    puts "#{self.name.capitalize} has broken to pieces"
    remove
  end
end

module Movable
  
  def take(callbacks = {})
    puts "Taken."
    remove
    if success = callbacks[:success]
      success.call
    end
  end

  def drop
  end
end

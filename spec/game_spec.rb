require_relative '../game'
require 'rspec'

describe Game do

  before do
    @game = Game.new
  end

  it 'returns the current room the player is in' do
    @game.current_room
  end
end
require_relative '../room'
require 'rspec'

describe Room do

  before do
    @room = Room.new
  end

  it 'returns the available exits' do
    @room.exits.should be_empty
  end
end
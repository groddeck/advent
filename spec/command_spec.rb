require_relative '../command'
require_relative '../game'
require 'rspec'

describe Command do

  before do
    @game = Game.new
  end

  it 'maps terms to actions and objects' do
    command = Command.create(["hello"], [], @game)
    command.action.text.should == 'hello'
    command.should be_corrupt

    command = Command.create(["hello"], [{'term' => 'hello'}], @game)
    command.action.text.should == 'hello'
    command.should_not be_corrupt
  end

  it 'executes to change the game state' do
    ball = MovableObject.new(name: 'ball')
    ball.move(@game.world)
    command = Command.create ['hit', 'ball'], [{'term' => 'hit', 'proc' => Proc.new {ball.to_s}}], @game
    command.execute
    # ball.should_receive(:to_s)
  end
end
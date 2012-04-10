require_relative '../command'
require_relative '../game'
require 'rspec'

describe "Command" do
  
  it 'maps terms to actions and objects' do
    game = Game.new
    command = Command.create(["hello"], [], game)
    command.action.text.should == 'hello'
    command.should be_corrupt

    command = Command.create(["hello"], [{'term' => 'hello'}], game)
    command.action.text.should == 'hello'
    command.should_not be_corrupt
  end

end
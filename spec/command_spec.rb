require_relative '../command'
require 'rspec'

describe "Command" do
  
  it 'maps terms to actions and objects' do
    command = Command.create(["hello"], [], [])
    command.action.text.should == 'hello'
    command.should be_corrupt

    command = Command.create(["hello"], [{'term' => 'hello'}], [])
    command.action.text.should == 'hello'
    command.should_not be_corrupt
  end

end
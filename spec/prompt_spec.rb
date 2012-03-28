require_relative '../prompt'
require 'rspec'

describe "Prompt" do
  # before do
  # end
  
  # it 'searches on name'
  # it 'searches on email'
  # it 'resets results when summary criteria are removed'
  
  it 'parses an input string into a command' do
    command = Prompt.new.parse("hello")
    raise 'no command given' if !command.is_a? Command
  end

end
require 'spec_helper'

describe 'Terminal Paint REPL' do
  it 'prints to stdout when called as a binary' do
    expect(`bundle exec terminal_paint`).to include('Hello from binary')
  end
end

require 'spec_helper'

module TerminalPaint
  describe CommandParser do
    context 'when called with the I M N command' do
      it 'initializes and renders a canvas' do
        command = 'I 5 5'
        canvas = described_class.parse(command)

        output = Array.new(5) { Array.new(5) { 'O' } }.map { |a| a.join(' ') }
        expect(canvas).to eq(output)
      end
    end
  end
end

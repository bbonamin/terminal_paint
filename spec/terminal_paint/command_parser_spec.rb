require 'spec_helper'

module TerminalPaint
  describe CommandParser do
    context 'when called with the I M N command' do
      it 'initializes and renders a canvas' do
        command = 'I 5 5'
        described_class.parse(command)

        output = Array.new(5) { Array.new(5) { 'O' } }.map { |a| a.join(' ') }
        expect(Canvas.instance.render).to eq(output)
      end
    end

    context 'when called with the L X Y C command' do
      before do
        command = 'I 5 5'
        @canvas = described_class.parse(command)
      end

      it 'colors the pixel (X, Y) with the color C' do
        command = 'L 1 1 C'
        described_class.parse(command)
        expect(Canvas.instance.raw.first.first).to eq('C')
        expect(Canvas.instance.raw.first.last).to_not eq('C')
      end
    end
  end
end

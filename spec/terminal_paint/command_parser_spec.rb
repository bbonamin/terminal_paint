require 'spec_helper'

module TerminalPaint
  describe CommandParser do
    describe 'the I M N command' do
      it 'initializes and renders a canvas' do
        command = 'I 5 5'
        described_class.parse(command)

        output = Array.new(5) { Array.new(5) { 'O' } }.map { |a| a.join(' ') }
        expect(Canvas.instance.render).to eq(output)
      end
    end

    describe 'the L X Y C command' do
      before do
        command = 'I 5 5'
        described_class.parse(command)
      end

      it 'colors the pixel (X, Y) with the color C' do
        command = 'L 1 1 C'
        described_class.parse(command)
        expect(Canvas.instance.raw.first.first).to eq('C')
        expect(Canvas.instance.raw.first.last).to_not eq('C')
      end
    end

    describe 'the V X Y1 Y2 C command' do
      before do
        command = 'I 5 5'
        described_class.parse(command)
      end

      it 'draws a line at X=1 from Y1=2 to Y2=4 of colour C' do
        command = 'V 1 2 4 C'
        described_class.parse(command)
        expect(Canvas.instance.raw[1][0]).to eq('C')
        expect(Canvas.instance.raw[2][0]).to eq('C')
        expect(Canvas.instance.raw[3][0]).to eq('C')
      end
    end
  end
end

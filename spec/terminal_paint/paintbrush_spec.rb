require 'spec_helper'

module TerminalPaint
  describe Paintbrush do
    before do
      Canvas.instance.draw(x: 5, y: 6)
    end

    describe '#paint_canvas' do
      it 'paints a given pixel on the canvas' do
        paintbrush = described_class.new(colour: 'C')
        paintbrush.paint_canvas(x: 1, y: 1)
        expect(Canvas.instance.raw.first.first).to eq('C')
      end
    end

    describe '#paint_vertical_line' do
      it 'paints a vertical line on the canvas' do
        paintbrush = described_class.new(colour: 'C')
        paintbrush.paint_vertical_line(x: 2, from: 2, to: 5)

        expect(Canvas.instance.raw[1][1]).to eq('C')
        expect(Canvas.instance.raw[2][1]).to eq('C')
        expect(Canvas.instance.raw[3][1]).to eq('C')
        expect(Canvas.instance.raw[4][1]).to eq('C')
      end
    end

    describe '#paint_horizontal_line' do
      it 'paints a horizontal line on the canvas' do
        paintbrush = described_class.new(colour: 'C')
        paintbrush.paint_horizontal_line(y: 3, from: 1, to: 3)

        expect(Canvas.instance.raw[2][0]).to eq('C')
        expect(Canvas.instance.raw[2][1]).to eq('C')
        expect(Canvas.instance.raw[2][2]).to eq('C')
      end
    end
  end
end

require 'spec_helper'

module TerminalPaint
  describe Paintbrush do
    before do
      Canvas.instance.draw(x: 5, y: 6)
    end

    describe '.paint_canvas' do
      it 'paints a given pixel on the canvas' do
        paintbrush = described_class.new(colour: 'C')
        paintbrush.paint_canvas(x: 1, y: 1)
        expect(Canvas.instance.raw.first.first).to eq('C')
      end
    end
  end
end

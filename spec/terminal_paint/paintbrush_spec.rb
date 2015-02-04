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

      it 'raises an error if not possible to build a line' do
        paintbrush = described_class.new(colour: 'C')
        expect do
          paintbrush.paint_vertical_line(x: 2, from: 10, to: 1)
        end.to raise_error(LineLengthInvalidError)

        paintbrush = described_class.new(colour: 'C')
        expect do
          paintbrush.paint_vertical_line(x: 2, from: 1, to: 1)
        end.to raise_error(LineLengthInvalidError)
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

      it 'raises an error if not possible to build a line' do
        paintbrush = described_class.new(colour: 'C')
        expect do
          paintbrush.paint_horizontal_line(y: 3, from: 3, to: 1)
        end.to raise_error(LineLengthInvalidError)

        paintbrush = described_class.new(colour: 'C')
        expect do
          paintbrush.paint_horizontal_line(y: 3, from: 5, to: 5)
        end.to raise_error(LineLengthInvalidError)
      end
    end

    describe '#fill_region' do
      it 'changes the whole canvas color when it only has one color' do
        paintbrush = described_class.new(colour: 'C')
        paintbrush.fill_region(x: 1, y: 1)
        expect(Canvas.instance.raw.flatten.uniq).to eq(['C'])
      end

      context 'when the canvas is divided by a vertical line' do
        before do
          paintbrush = described_class.new(colour: 'B')
          paintbrush.paint_vertical_line(x: 3, from: 1, to: 6)
        end

        it 'only fills the left region if you fill for (1, 1)' do
          paintbrush = described_class.new(colour: 'X')
          paintbrush.fill_region(x: 1, y: 1)
          expect(Canvas.instance.raw.map { |row| row[0] }.uniq).to eq(['X'])
          expect(Canvas.instance.raw.map { |row| row[1] }.uniq).to eq(['X'])
          expect(Canvas.instance.raw.map { |row| row[2] }.uniq).to eq(['B'])
          expect(Canvas.instance.raw.map { |row| row[3] }.uniq).to eq(['O'])
          expect(Canvas.instance.raw.map { |row| row[4] }.uniq).to eq(['O'])
        end

        it 'only fills the right region if you fill for (5,6)'  do
          paintbrush = described_class.new(colour: 'X')
          paintbrush.fill_region(x: 5, y: 6)
          expect(Canvas.instance.raw.map { |row| row[0] }.uniq).to eq(['O'])
          expect(Canvas.instance.raw.map { |row| row[1] }.uniq).to eq(['O'])
          expect(Canvas.instance.raw.map { |row| row[2] }.uniq).to eq(['B'])
          expect(Canvas.instance.raw.map { |row| row[3] }.uniq).to eq(['X'])
          expect(Canvas.instance.raw.map { |row| row[4] }.uniq).to eq(['X'])
        end
      end
      context 'when the canvas is divided by a horizontal line' do
        before do
          paintbrush = described_class.new(colour: 'B')
          paintbrush.paint_horizontal_line(y: 3, from: 1, to: 5)
        end

        it 'only fills the top region if you fill for (1, 1)' do
          paintbrush = described_class.new(colour: 'X')
          paintbrush.fill_region(x: 1, y: 1)
          expect(Canvas.instance.raw[0].uniq).to eq(['X'])
          expect(Canvas.instance.raw[1].uniq).to eq(['X'])
          expect(Canvas.instance.raw[2].uniq).to eq(['B'])
          expect(Canvas.instance.raw[3].uniq).to eq(['O'])
          expect(Canvas.instance.raw[4].uniq).to eq(['O'])
          expect(Canvas.instance.raw[5].uniq).to eq(['O'])
        end

        it 'only fills the top region if you fill for (5, 6)' do
          paintbrush = described_class.new(colour: 'X')
          paintbrush.fill_region(x: 5, y: 6)
          expect(Canvas.instance.raw[0].uniq).to eq(['O'])
          expect(Canvas.instance.raw[1].uniq).to eq(['O'])
          expect(Canvas.instance.raw[2].uniq).to eq(['B'])
          expect(Canvas.instance.raw[3].uniq).to eq(['X'])
          expect(Canvas.instance.raw[4].uniq).to eq(['X'])
          expect(Canvas.instance.raw[5].uniq).to eq(['X'])
        end
      end

      context 'when there is a horizontal and vertical line' do
        before do
          paintbrush = described_class.new(colour: 'B')
          paintbrush.paint_vertical_line(x: 3, from: 1, to: 6)

          paintbrush = described_class.new(colour: 'C')
          paintbrush.paint_horizontal_line(y: 3, from: 1, to: 5)
        end

        it 'only fills the top left region when filling for (1, 1)' do
          paintbrush = described_class.new(colour: 'D')
          paintbrush.fill_region(x: 1, y: 1)
          expect(Canvas.instance.colour_at(x: 1, y: 1)).to eq('D')
          expect(Canvas.instance.colour_at(x: 1, y: 2)).to eq('D')
          expect(Canvas.instance.colour_at(x: 2, y: 1)).to eq('D')
          expect(Canvas.instance.colour_at(x: 2, y: 2)).to eq('D')
        end
      end
    end
  end
end

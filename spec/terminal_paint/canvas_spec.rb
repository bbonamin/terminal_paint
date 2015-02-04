require 'spec_helper'

module TerminalPaint
  describe Canvas do
    before(:each) do
      # Reset singleton since it's unique on each TerminalPaint run
      Singleton.__init__(Canvas)
    end

    it 'is saved internally as a 5 x 6 canvas' do
      output = Array.new(6) { Array.new(5) { 'O' } }

      described_class.instance.draw(x: 5, y: 6)
      expect(described_class.instance.raw).to eq(output)
    end

    it 'is rendered as a multiline string' do
      output = Array.new(6) { Array.new(5) { 'O' } }
      rendered_output = output.map { |a| a.join(' ') }

      described_class.instance.draw(x: 5, y: 6)
      expect(described_class.instance.render).to eq(rendered_output)
    end

    it 'raises an exception if raw is called without drawing first' do
      expect { described_class.instance.raw }.to raise_error(StandardError)
    end

    it 'raises an exception if render is called without drawing first' do
      expect { described_class.instance.render }.to raise_error(StandardError)
    end

    describe '#colour_at' do
      before(:each) do
        described_class.instance.draw(x: 5, y: 6)
      end

      it 'returns the colour at a given position' do
        expect(Canvas.instance.colour_at(x: 1, y: 1)).to eq('O')
      end

      context 'if a color is passed as an argument' do
        it 'changes the colour at a given position' do
          expect(Canvas.instance.colour_at(x: 1, y: 1)).to eq('O')

          Canvas.instance.colour_at(x: 1, y: 1, colour: 'R')
          expect(Canvas.instance.raw.first.first).to eq('R')
        end

        it 'raises an exception if the colour is not a letter' do
          expect do
            Canvas.instance.colour_at(x: 1, y: 1, colour: '!')
          end.to raise_error(ArgumentError)
          expect do
            Canvas.instance.colour_at(x: 1, y: 1, colour: 7)
          end.to raise_error(ArgumentError)
        end
      end
    end

    describe '#adjacent_pixels_with_colour' do
      before(:each) do
        described_class.instance.draw(x: 5, y: 6)
      end

      context 'when the whole 5x6 canvas is of the same colour' do
        it 'returns bottom and right pixels for (1, 1)' do
          x, y = 1, 1
          adjacent_pixels =
            described_class.instance.adjacent_pixels_with_colour(
            x: x,
            y: y,
            colour: 'O')
          expect(adjacent_pixels.count).to eq(2)
          expect(adjacent_pixels).to include([1, 2])
          expect(adjacent_pixels).to include([2, 1])
        end

        it 'returns top, right, bottom and left pixels for (3,3)' do
          x, y = 3, 3
          adjacent_pixels =
            described_class.instance.adjacent_pixels_with_colour(
            x: x,
            y: y,
            colour: 'O')
          expect(adjacent_pixels.count).to eq(4)
          expect(adjacent_pixels).to include([3, 4])
          expect(adjacent_pixels).to include([3, 2])
          expect(adjacent_pixels).to include([4, 3])
          expect(adjacent_pixels).to include([2, 3])
        end

        it 'returns top and left pixels for (5,6)' do
          x, y = 5, 6
          adjacent_pixels =
            described_class.instance.adjacent_pixels_with_colour(
            x: x,
            y: y,
            colour: 'O')
          expect(adjacent_pixels.count).to eq(2)
          expect(adjacent_pixels).to include([5, 5])
          expect(adjacent_pixels).to include([4, 6])
        end
      end
    end
  end
end

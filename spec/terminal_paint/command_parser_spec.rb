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

    describe 'the S command' do
      before do
        command = 'I 5 5'
        described_class.parse(command)
      end

      it 'renders the canvas in a puttable fashion' do
        command = 'S'
        stdout = StringIO.new
        described_class.parse(command, stdout)
        expect(stdout.string).to eq(Canvas.instance.render.join("\n") << "\n")
      end
    end
    describe 'the L X Y C command' do
      before do
        command = 'I 5 5'
        described_class.parse(command)
      end

      it 'colours the pixel (X, Y) with the colour C' do
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

    describe 'the H X1 X2 Y C command' do
      before do
        command = 'I 5 5'
        described_class.parse(command)
      end

      it 'draws a line  from X1=3 to X2=5 of colour C at Y=4' do
        command = 'H 3 5 4 C'
        described_class.parse(command)
        expect(Canvas.instance.raw[3][2]).to eq('C')
        expect(Canvas.instance.raw[3][3]).to eq('C')
        expect(Canvas.instance.raw[3][4]).to eq('C')
      end
    end

    describe 'F X Y C command' do
      before do
        command = 'I 5 5'
        described_class.parse(command)
      end

      it 'fills the entire canvas if it only has one colour' do
        command = 'F 1 1 C'
        described_class.parse(command)
        expect(Canvas.instance.raw.flatten.uniq).to eq(['C'])
      end
    end

    describe 'the Z command' do
      before do
        command = 'I 5 5'
        described_class.parse(command)
      end

      it 'inverts the current colours of the canvas' do
        command = 'Z'
        described_class.parse(command)
        expect(Canvas.instance.raw.flatten.uniq).to eq(['L'])
      end
    end
  end
end

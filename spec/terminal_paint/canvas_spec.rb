require 'spec_helper'

module TerminalPaint
  describe Canvas do
    it 'is saved internally as a 5 x 6 canvas' do
      output = Array.new(6) { Array.new(5) { 'O' } }
      expect(described_class.new(x: 5, y: 6).raw).to eq(output)
    end

    it 'is rendered as a multiline string' do
      output = Array.new(6) { Array.new(5) { 'O' } }
      rendered_output = output.map { |a| a.join(' ') }
      expect(described_class.new(x: 5, y: 6).render).to eq(rendered_output)
    end
  end
end

module TerminalPaint
  class Canvas
    attr_reader :raw
    DEFAULT_COLOR = 'O'

    def initialize(x:, y:)
      @x, @y = x, y
      @raw = Array.new(@y) { Array.new(@x) { DEFAULT_COLOR } }
    end

    def render
      @raw.map { |a| a.join(' ') }
    end
  end
end

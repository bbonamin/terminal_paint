require 'singleton'
module TerminalPaint
  class Canvas
    include Singleton

    DEFAULT_COLOR = 'O'

    def draw(x:, y:)
      @x, @y = x, y
      @raw = Array.new(@y) { Array.new(@x) { DEFAULT_COLOR } }
    end

    def render
      fail(StandardError, 'You must draw the canvas first') if @raw.nil?
      @raw.map { |a| a.join(' ') }
    end

    def raw
      @raw || fail(StandardError, 'You must draw the canvas first')
    end

    def colour_at(x:, y:, colour: nil)
      absolute_x, absolute_y = x - 1, y - 1
      if colour.nil?
        @raw[absolute_y][absolute_x]
      else
        unless colour.to_s.match(/[a-zA-Z]/)
          fail(ArgumentError, 'Colour must be a letter')
        end
        @raw[absolute_y][absolute_x] = colour.upcase
      end
    end
  end
end

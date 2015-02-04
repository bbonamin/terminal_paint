require 'singleton'
module TerminalPaint
  class Canvas
    include Singleton

    DEFAULT_COLOR = 'O'
    VALID_COLOURS = ('A'..'Z')

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
        unless VALID_COLOURS.cover?(colour)
          fail(ArgumentError, 'Colour must be an upcase letter')
        end
        @raw[absolute_y][absolute_x] = colour
      end
    end

    def adjacent_pixels_with_colour(x:, y:, colour:)
      coords = (
        [x.succ, x.pred].product([y]) +
        [x].product([y.succ, y.pred])
      ).select do |coord|
        (1..@x).cover?(coord.first) && (1..@y).cover?(coord.last)
      end

      coords.select do |coord|
        colour_at(x: coord[0], y: coord[1]) == colour
      end
    end

    def invert_colours!
      valid_colours = VALID_COLOURS.to_a
      inverted_colours = valid_colours.reverse
      @raw = @raw.map do |row|
        row.map do |pixel|
          inverted_colours[valid_colours.index(pixel)]
        end
      end
    end
  end
end

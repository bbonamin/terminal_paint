require 'singleton'
module TerminalPaint
  class Canvas
    include Singleton

    DEFAULT_COLOUR = 'O'
    VALID_COLOURS = ('A'..'Z')

    def draw(x:, y:)
      @x, @y = x, y
      @raw = Array.new(@y) { Array.new(@x) { DEFAULT_COLOUR } }
    end

    def render
      raw.map { |a| a.join(' ') }
    end

    def raw
      validate_canvas!
      @raw
    end

    def colour_at(x:, y:, colour: nil)
      validate_canvas!
      validate_coordinates!(x: x, y: y)
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
        coordinates_within_boundaries(x: coord.first, y: coord.last)
      end

      coords.select do |coord|
        colour_at(x: coord[0], y: coord[1]) == colour
      end
    end

    def invert_colours!
      validate_canvas!
      valid_colours = VALID_COLOURS.to_a
      inverted_colours = valid_colours.reverse
      @raw = @raw.map do |row|
        row.map do |pixel|
          inverted_colours[valid_colours.index(pixel)]
        end
      end
    end

    private

    def validate_canvas!
      return true unless @raw.nil?
      fail(CanvasNotPresentError, 'You must draw the canvas first')
    end

    def validate_coordinates!(x:, y:)
      return true if coordinates_within_boundaries(x: x, y: y)
      fail CoordinatesOutOfBoundError,
           "Coordinates must be between 1 and #{@x} for X" \
            " and between 1 and #{@y} for Y"
    end

    def coordinates_within_boundaries(x:, y:)
      (1..@x).cover?(x) && (1..@y).cover?(y)
    end
  end
end

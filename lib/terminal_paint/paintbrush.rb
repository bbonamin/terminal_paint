module TerminalPaint
  class Paintbrush
    def initialize(colour:)
      @colour = colour
    end

    def paint_canvas(x:, y:)
      Canvas.instance.colour_at(x: x, y: y, colour: @colour)
    end

    def paint_vertical_line(x:, from:, to:)
      validate_line_length!(from: from, to: to)
      from.upto(to) do |y|
        Canvas.instance.colour_at(x: x, y: y, colour: @colour)
      end
    end

    def paint_horizontal_line(y:, from:, to:)
      validate_line_length!(from: from, to: to)
      from.upto(to) do |x|
        Canvas.instance.colour_at(x: x, y: y, colour: @colour)
      end
    end

    def fill_region(x:, y:)
      current_colour = Canvas.instance.colour_at(x: x, y: y)
      return if current_colour == @colour

      Canvas.instance.colour_at(x: x, y: y, colour: @colour)
      adjacent_pixels = Canvas.instance.adjacent_pixels_with_colour(
        x: x,
        y: y,
        colour: current_colour
      )

      adjacent_pixels.each do |pixel|
        fill_region(x: pixel.first, y: pixel.last)
      end
    end

    private

    def validate_line_length!(from:, to:)
      fail LineLengthInvalidError,
           'The line to paint should have a valid length' if (to <= from)
    end
  end
end

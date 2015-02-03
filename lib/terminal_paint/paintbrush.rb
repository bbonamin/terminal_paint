module TerminalPaint
  class Paintbrush
    def initialize(colour: fail(ArgumentError, 'colour is required'))
      @colour = colour
    end

    def paint_canvas(x:, y:)
      Canvas.instance.colour_at(x: x, y: y, colour: @colour)
    end

    def paint_vertical_line(x:, from:, to:)
      from.upto(to).with_index do |y|
        Canvas.instance.colour_at(x: x, y: y, colour: @colour)
      end
    end
  end
end

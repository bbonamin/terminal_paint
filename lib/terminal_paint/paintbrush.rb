module TerminalPaint
  class Paintbrush
    def self.paint_canvas(x:, y:, colour:)
      Canvas.instance.colour_at(x: x, y: y, colour: colour)
    end
  end
end

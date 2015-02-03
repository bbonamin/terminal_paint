module TerminalPaint
  class CommandParser
    def self.parse(input)
      input.match(/I\s+(\d+)\s+(\d+)/) do |match_data|
        Canvas.instance.draw(
          x: match_data[1].to_i,
          y: match_data[2].to_i
        )
      end
      input.match(/L\s+(\d+)\s+(\d+)\s+([A-Z])/) do |match_data|
        Paintbrush.paint_canvas(
          x: match_data[1].to_i,
          y: match_data[2].to_i,
          colour: match_data[3]
        )
      end
    end
  end
end

module TerminalPaint
  class CommandParser
    def self.parse(input)
      input.match(/I\s+(\d+)\s+(\d+)/) do |match_data|
        @output = Canvas.new(
                    x: match_data[1].to_i,
                    y: match_data[2].to_i
                  ).render
      end

      @output
    end
  end
end

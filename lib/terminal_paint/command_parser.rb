module TerminalPaint
  module CommandParser
    COLOUR = '\s+([A-Z])'
    COORD = '\s+(\d+)'
    MENU_OPTIONS = {
      draw_canvas: /I#{COORD}#{COORD}/,
      render_canvas: /^S$/,
      paint_canvas: /L#{COORD}#{COORD}#{COLOUR}/,
      paint_vertical_line: /V#{COORD}#{COORD}#{COORD}#{COLOUR}/,
      paint_horizontal_line: /H#{COORD}#{COORD}#{COORD}#{COLOUR}/,
      fill_region: /F#{COORD}#{COORD}#{COLOUR}/,
      invert_colours: /^Z$/
    }

    def self.parse(input, stdout = $stdout)
      @stdout = stdout
      MENU_OPTIONS.each_pair do |key, value|
        match_data = input.match(value)
        if match_data
          send(key, match_data)
          break
        end
      end
    end

    def self.draw_canvas(match_data)
      Canvas.instance.draw(
        x: match_data[1].to_i,
        y: match_data[2].to_i
      )
    end

    def self.render_canvas(_)
      @stdout.puts Canvas.instance.render
    end

    def self.paint_canvas(match_data)
      Paintbrush.new(colour: match_data[3]).paint_canvas(
        x: match_data[1].to_i,
        y: match_data[2].to_i
      )
    end

    def self.paint_vertical_line(match_data)
      Paintbrush.new(colour: match_data[4]).paint_vertical_line(
        x: match_data[1].to_i,
        from: match_data[2].to_i,
        to: match_data[3].to_i
      )
    end

    def self.paint_horizontal_line(match_data)
      Paintbrush.new(colour: match_data[4]).paint_horizontal_line(
        from: match_data[1].to_i,
        to: match_data[2].to_i,
        y: match_data[3].to_i
      )
    end

    def self.fill_region(match_data)
      Paintbrush.new(colour: match_data[3]).fill_region(
        x: match_data[1].to_i,
        y: match_data[2].to_i
      )
    end

    def self.invert_colours(_)
      Canvas.instance.invert_colours!
    end
  end
end

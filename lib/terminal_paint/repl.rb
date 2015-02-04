module TerminalPaint
  class REPL
    def initialize(stdin = $stdin, stdout = $stdout)
      @stdin = stdin
      @stdout = stdout
    end

    def run
      @stdout.puts 'Welcome to TerminalPaint'
      @stdout.puts 'Type X to terminate the session'
      loop do
        begin
          @stdout.print '>'
          input = @stdin.gets.to_s.chomp.strip
          CommandParser.parse(input, @stdout)
        rescue StandardError => e
          @stdout.puts "Error: #{e.message}"
        end
      end
    end
  end
end

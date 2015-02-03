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
        @stdout.print '>'
        input = @stdin.gets.to_s.chomp.strip
        break if input == 'X'
        puts CommandParser.parse(input)
      end
    end
  end
end

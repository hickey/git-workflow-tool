
require 'optparse'

module GWT
  class Cli

    attr_reader :options
    attr_reader :command
    attr_reader :args
    
    
    def initialize
      @options = { :verbose       => false
      
        }
      @command = nil
      @args = []
    end
    
    
    def parse
      
      # find any switches specified on the command line
      OptionParser.new do |opt|
        
        opt.on('--verbose', '-v', 'Print verbose messages') {
          @options[:verbose] = true
        }
        
        opt.on('--version', '-V', 'Display version') {
          puts VERSION
          exit
        }
        
      end.parse!

      # look for the subcommand
      if ARGV.count > 0
        @command = ARGV.shift
        @args = ARGV
      end


    end
    

  end
end

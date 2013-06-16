
module GWT
  module Command
    module Help
      
      GWT::Command::Help.set_help <<-HELP
|help
  Display the help information
  Toplevel help showing the basic commands 
HELP
      
      module_function 
      def perform(repo, args)
        if args.empty?
          @@help.keys.sort.each {|define|  puts define }
        elsif args.size == 1
          @@help.keys.sort.each {|define|
            if define.start_with? args[0]
              puts "  #{define}"
              puts "    #{@@help[define][:summary]}"
            end
          }
        elsif args[0] == "search" and args.size > 2
          # search definitions 
          puts "Searching"
        else
          @@help.keys.sort.each {|define|
            if define.start_with? args.join(' ')
              puts "  #{define}"
              puts "    #{@@help[define][:details].join("\n    ")}"
            end
          }
        end
      end
    end
  end
end

module GWT
  module Command
    module Version
      
      GWT::Command::Help.set_help <<-HELP
|version
  Display the version information for gwt
  Display the version information for gwt
HELP
      
      module_function 
      def perform(repo, args)
        puts "GWT Version #{GWT::VERSION}"
      end
    end
  end
end
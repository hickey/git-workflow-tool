
module GWT
  module Command
    module Info
      
      GWT::Command::Help.set_help <<-HELP
|info
  Display the current settings for gwt
  Show the current workflow settings 
HELP
      
      module_function 
      def perform(repo, args)
        puts "Integration branch: #{GWT::config_get('gwt.integration')}"
        puts "Canary branch     : #{GWT::config_get('gwt.canary')}"
        puts "Production branch : #{GWT::config_get('gwt.production')}"
      end
    end
  end
end

module GWT
  module Command
    module Info
      
      module_function 
      
      def perform(repo, args)
        puts "Integration branch: #{GWT::config_get('gwt.integration')}"
        puts "Canary branch     : #{GWT::config_get('gwt.canary')}"
        puts "Production branch : #{GWT::config_get('gwt.production')}"
      end
    end
  end
end
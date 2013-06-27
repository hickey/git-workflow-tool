
module GWT
  module Command
    module License
      
      GWT::Command::Help.set_help <<-HELP
|license
  Display the license information for gwt
  Display the license information for gwt
HELP
      
      module_function 
      def perform(repo, args)
        my_install_dir = File.dirname(__FILE__) + '/../../../'
        if File.exist? "#{my_install_dir}/LICENSE.txt"
          File.open("#{my_install_dir}/LICENSE.txt", 'r') {|f|
            while line = f.gets
              puts line
            end
          }
        else
          puts "Unable to locate LICENSE.txt; You must have a pirated copy!"
        end
      end
    end
  end
end
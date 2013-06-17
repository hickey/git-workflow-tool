
module GWT
  module Command
    module Help
      
      @@help = {}
      
      module_function
      def set_help(text)
        # format for help is
        # |cmd|subcmd[|arg1|arg2]
        #   summary
        #   details
        cmd_line = nil
        text.split("\n").each do |line|
          case line[0]
          when 124       # first char is |
            # Command definition    (ruby 1.8.7)
            cmd_line = line.tr('|', ' ').strip
            @@help[cmd_line] = { :summary => nil, :details => nil }
          when '|'       # first char is |
            # Command definition   (ruby 1.9.3)
            cmd_line = line.tr('|', ' ').strip
            @@help[cmd_line] = { :summary => nil, :details => nil }
          else
            if cmd_line.nil?
              # whoa! Bad help text 
              raise ArgumentError, "Malformed help text"
            end
            
            if @@help[cmd_line][:summary].nil?
              # Summary text
              @@help[cmd_line][:summary] = line.strip
            elsif @@help[cmd_line][:details].nil?
              @@help[cmd_line][:details] = [ line.strip ]
            else
              @@help[cmd_line][:details] << line.strip 
            end
          end
        end
      end
    end
  end

  # Dynamically load any command plugins
  $LOAD_PATH.each do |dir|
    if File.directory? "#{dir}/gwt"
      Dir.foreach("#{dir}/gwt/command") do |file|
        if file.end_with? '.rb'
          require "gwt/command/#{File.basename(file, '.rb')}"
        end
      end
    end
  end
end



  
  
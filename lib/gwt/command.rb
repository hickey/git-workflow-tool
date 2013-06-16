
$LOAD_PATH.each do |dir|
  if File.directory? "#{dir}/gwt"
    Dir.foreach("#{dir}/gwt/command") do |file|
      if file.end_with? '.rb'
        require "gwt/command/#{File.basename(file, '.rb')}"
      end
    end
  end
end


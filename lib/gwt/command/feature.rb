

module GWT
  module Command
    module Feature
      
      module_function 
      
      def perform(repo, args)
        puts "Running feature"
        puts "repo = #{repo.inspect}"
        puts "args = #{args.inspect}"
      end
      
      
      
    end
  end
end
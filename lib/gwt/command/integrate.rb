
module GWT
  module Command
    module Integrate
      
      GWT::Command::Help.set_help <<-HELP
|integrate [<feature>]
  Integrate a given feature
  Merge the specified feature (or current feature branch) into the 
  integration branch and look for conflicts. 
HELP
      
      module_function 
      def perform(repo, args)
        
        # check for if the feature branch is specified
        if args.size > 1
          feature_branch = args[1]
        else 
          # check to see if the current branch is a feature
          puts "features = #{GWT::features}"
          puts "branch = #{repo.current_branch}"
          if GWT::features.member? repo.current_branch
            feature_branch = repo.current_branch
          else
            puts "Current branch is not a feature branch. Please specify feature."
            exit 2
          end
        end

        #TODO Check to see if all files have been committed

        # switch to integration branch and merge the feature branch
        repo.branch(GWT::integration).checkout
        repo.branch(feature_branch).merge
        
        # Need to check for conflicts. 
        
      end
    end
  end
end
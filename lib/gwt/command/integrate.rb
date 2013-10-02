
require 'gwt/error'

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
        if args.size == 1
          working_copy = args[0]
        else 
          # check to see if the current branch is a feature
          working_copy = repo.current_branch
        end
        
        unless GWT::is_feature_branch? working_copy
          GWT::Error.die "#{working_copy} is not a feature branch. Please specify a feature.", code=2
        end

        # insure that we are clean
        unless repo.status.clean? 
          GWT::Error.die "Not all changes have been committed. Please commit all changes first.", code=2
        end
        
        # save the branch so as to return to it after integration
        GWT::Repo.save_branch
        
        #TODO Check to see if all files have been committed

        # switch to integration branch and merge the feature branch
        begin
          repo.branch(GWT::integration_branch).checkout
          repo.pull
          repo.branch(working_copy).merge
          repo.push
        rescue Git::GitExecuteError => e
          if e.message.match "would be overwritten"
            GWT::Error.die "Current branch is not clean please commit before proceeding", code=2
          end
          GWT::Error.die "Unknown git failure: #{e.message}", code=2
        rescue Exception => e
          GWT::Error.die "Unknown exception while merging #{working_copy} into #{GWT::integration_branch}: #{e}", code=3
        end

        #TODO: Need to check for conflicts. 
        
        GWT::Repo.restore_branch        
      end
    end
  end
end
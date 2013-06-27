
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
          feature_branch = args[0]
        else 
          # check to see if the current branch is a feature
          feature_branch = repo.current_branch
        end
        
        unless GWT::is_feature_branch? feature_branch
          puts "#{feature_branch} is not a feature branch. Please specify a feature."
          exit 2
        end

        # insure that we are clean
        unless repo.status.changed.nil? and repo.status.added.nil? and repo.status.deleted.nil?
          puts "Not all changes have been committed. Please commit all changes first."
          exit 2
        end
        
        # save the branch so as to return to it after integration
        save_branch = repo.current_branch
        
        #TODO Check to see if all files have been committed

        # switch to integration branch and merge the feature branch
        begin
          repo.branch(GWT::integration_branch).checkout
          repo.pull
          repo.branch(feature_branch).merge
        rescue Git::GitExecuteError => e
          if e.message.match "would be overwritten"
            puts "Current branch is not clean please commit before proceeding"
            exit 2
          end
          puts "Unknown git failure: #{e.message}"
          exit 2
        rescue Exception => e
          puts "Unknown exception while merging #{feature_branch} into #{GWT::integration_branch}: #{e}"
          exit 3
        end

        #TODO: Need to check for conflicts. 
        
        repo.branch(save_branch).checkout
        
      end
    end
  end
end
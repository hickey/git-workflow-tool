
module GWT
  module Command
    module Set
      
      GWT::Command::Help.set_help <<-HELP
|set integration <branch>
  Set the integration branch
  Set the integration branch to the specified branch name.
|set workflow <branch> <branch> <branch>
  Specify branches that create the workflow
  Specify the branches the comprises the workflow.
HELP
      
      module_function 
      def perform(repo, args)
        # check to see if we have at least minimum # of arguments
        if args.size < 2
          puts "set requires at least 2 values"
          exit 2
        end
        
        case args[0]
        when 'integration'
          repo.branch(GWT.integration).checkout
          GWT.integration = args[1]
          
          if repo.is_branch? GWT.integration
            repo.branch(GWT.integration).checkout
          else
            repo.branch(GWT.integration).create
          end
        
        when 'workflow'
          GWT.workflow= args[1..-1]
          
          current_branch = repo.current_branch
          args[1..-1].each do |branch|
            unless repo.is_branch? branch
              repo.branch(GWT.integration).checkout
              repo.branch(branch).create
            end
          end
          repo.branch(current_branch).checkout
          
        end
      end
    end
  end
end
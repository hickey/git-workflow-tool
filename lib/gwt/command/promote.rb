
module GWT
  module Command
    module Promote
      
      GWT::Command::Help.set_help <<-HELP
|promote [<from_branch>] <to_branch>
  Promote current branch or specified branch to a branch
  Promote the current branch, if from_branch is not specified, to the 
  specified branch. If the from_branch has not yet been integrated, 
  the integration process will occur first and upon completion be 
  promoted to the specified to_branch. 
HELP
      
      module_function 
      def perform(repo, args)
        if args.size == 1
          from_branch = repo.current_branch
          to_branch = args[0]
        elsif args.size == 2
          from_branch = args[0]
          to_branch = args[1]
        else
          puts "promote does not accept more than 2 args at this time."
          exit 2
        end
        
        # check to see if to_branch is a branch in the workflow
        if not GWT::is_workflow_branch? to_branch
          puts "The branch being promoted to (#{to_branch}) is not part of the workflow."
          exit 2
        end
        
        # check to see if the from_branch has been integrated / workflow
        if not GWT::is_workflow_branch? from_branch and
           not GWT::is_integration_branch? from_branch
          # Then we need to integrate it now
          GWT::Command::Integrate.perform(repo, from_branch)
          from_branch = GWT::integration_branch
        end
        
        # build a list of workflow branches to promote through  
        workflow = [GWT::integration_branch, GWT::workflow]
        workflow.flatten!
        select_branch = false
        promote_branches = workflow.select do |branch|
          if branch == from_branch
            select_branch = true
          elsif branch == to_branch
            select_branch = false
            true
          else
            select_branch
          end
        end
        
        puts "promote_branches = #{promote_branches.inspect}"
          

        
        
      end
    end
  end
end
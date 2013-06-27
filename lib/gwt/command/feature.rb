

module GWT
  module Command
    module Feature
      
      GWT::Command::Help.set_help <<-HELP
|feature create <name>
  Add a new feature
  Create a new feature branch and change to it.
|feature list
  Show a list of existing features
  Show a list of existing features.
|feature delete <name>
  Delete a feature
  Remove an existing feature specified by <name>. This will delete all 
  changes associated with the feature that have not yet been merged into
  the integration branch. After execution, repo will be on the 
  integration branch.
HELP

      module_function
      def perform(repo, args)
        feature_cmd = args.shift
        feature_name = args.shift
        features = GWT::feature_branches.to_a
        
        case feature_cmd
        when %r{create|add}
          if feature_name.nil?
            puts "Feature name not specified"
            exit 2
          end
          repo.branch(GWT::integration_branch).checkout
          repo.branch(feature_name).create
          repo.branch(feature_name).checkout
          features << feature_name
          GWT::config_set('gwt.features', features)
          
        when %r{list}
          unless features.nil?
            features.each {|f| puts f}
          end
          
        when %r{delete|del|remove|rm}
         if feature_name.nil?
            puts "Feature name not specified"
            exit 2
          end
          repo.branch(GWT::integration_branch).checkout
          repo.branch(feature_name).delete
          features.delete(feature_name)
          GWT::config_set('gwt.features', features)
        
        else
          puts "Unknown subcommand"
        end
          
      end
    end
  end
end
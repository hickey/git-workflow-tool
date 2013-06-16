

module GWT
  module Command
    module Feature
      
      module_function 
      
      def perform(repo, args)
        feature_cmd = args.shift
        feature_name = args.shift
        features = GWT::config_get('gwt.features').to_a
        
        case feature_cmd
        when %r{create|add}
          if feature_name.nil?
            puts "Feature name not specified"
            exit 2
          end
          repo.branch('master').checkout
          repo.branch(feature_name).create
          repo.branch(feature_name).checkout
          features << feature_name
          puts "features = #{features.inspect}"
          
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
          repo.branch('master').checkout
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
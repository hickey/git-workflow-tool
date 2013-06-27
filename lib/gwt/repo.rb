
require 'git'


module GWT
  module Repo
    
    @@obj = nil
    @@save_branch = []
    
    module_function
    
    def open
      workdir = find_toplevel
      if workdir.nil?
        puts "Command must be run under Git working directory"
        exit 1
      end
      
      @@obj = Git.open(workdir)
      return @@obj
    end
    
    
    def find_toplevel
      # ascend through the directories until the toplevel directory is found
      dirs = Dir.pwd.split('/')
      until dirs.count == 0 do
        testdir = dirs.join('/')
        if File.directory?("#{testdir}/.git")
          return testdir
        end
        dirs.pop
      end
      
      return nil
    end
        
        
    # Convenence function for saving the branch and returning to it
    # at a later time
    def save_branch
      @@save_branch << @@obj.current_branch
    end
    
    # Restore branch to a previously saved location
    def restore_branch
      @@obj.branch(@@save_branch.pop).checkout
    end
    
    
  end
end

# Monkey patch Git gem
module Git
  class Status
    def clean?
      changed.empty? and added.empty? and deleted.empty?
    end
  end
end
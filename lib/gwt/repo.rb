
require 'git'


module GWT
  module Repo
    
    module_function
    
    def open
      workdir = find_toplevel
      if workdir.nil?
        puts "Command must be run under Git working directory"
        exit 1
      end
      
      gitrepo = Git.open(workdir)
      return gitrepo
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
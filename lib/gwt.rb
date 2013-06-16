
require 'rubygems'
require 'gwt/cli'
require 'gwt/repo'
require 'gwt/command'


module GWT
  
  VERSION = '0.0.1'

  @repo = GWT::Repo.open
  @config = {}
  @repo.config.keys.grep(%r{^gwt\.}).each {|k| @config[k] = @repo.config(k)}

  module_function
  
  def repo;  @repo  end
  def config;  @config  end
  def config_set(key, val)
    @repo.config(key, val)
    @config[key] = val
  end
  def config_del(key)
    %x{git config --unset #{key}}
    @config.delete(key)
  end


end

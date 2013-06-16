
require 'rubygems'
require 'gwt/cli'
require 'gwt/repo'
require 'gwt/command'


module GWT
  
  VERSION = '0.0.1'

  @repo = GWT::Repo.open
  @config = {}
  
  def load_config
    repo.config.keys.grep(%r{^gwt\.}).each {|k| @config[k] = repo.config(k)}
  end
  
  module_function
  
  def repo;  @repo  end
  def config;  @config  end
  def config=(key, val)
    repo.config(key, val)
    load_config
  end


end

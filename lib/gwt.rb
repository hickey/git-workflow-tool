
require 'rubygems'
require 'json'

require 'gwt/cli'
require 'gwt/repo'
require 'gwt/command'


module GWT
  
  VERSION = '0.0.1'

  @repo = GWT::Repo.open
  @config = {}
  
  # load the configuration into @config
  keys = @repo.config.keys.grep(%r{^gwt\.})
  unless keys.nil?
    keys.each {|k| @config[k] = @repo.config(k)}
  end
  
  
  module_function
  
  def repo;  @repo  end
  def config;  @config  end
  def config_get(key)
    val = @config[key]
    unless val.nil?
      if val.start_with? '['
        val = JSON.parse val
      end
    end
    val
  end
  def config_set(key, val)
    if val.is_a? Array
      puts "trying to save an array: #{val.inspect}"
      puts "JSON = #{val.to_json}"
      %x{git config #{key} '#{val.to_json}'}
    else 
      %x{git config #{key} #{val}}
    end
    @config[key] = val
  end
  def config_del(key)
    %x{git config --unset #{key}}
    @config.delete(key)
  end


end


require 'rubygems'
require 'json'

require 'gwt/cli'
require 'gwt/repo'
require 'gwt/command'


module GWT
  
  VERSION = '1.0.0'

  @repo = GWT::Repo.open
  @config = {}
  
  # load the configuration into @config
  keys = @repo.config.keys.grep(%r{^gwt\.})
  unless keys.nil?
    keys.each {|k| @config[k] = @repo.config[k]}
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

  def integration_branch;  config_get('gwt.integration')  end
  def integration_branch= v;  config_set('gwt.integration', v)  end
  def is_integration_branch? val;  integration_branch == val  end
  unless keys.member? 'gwt.integration'
    config_set('gwt.integration', 'master')
  end
  
  
  def workflow; config_get('gwt.workflow')  end
  def workflow= v
    if v.is_a? Array
      config_set('gwt.workflow', v)
    else
      config_set('gwt.workflow', v.split(':'))
    end
  end
  def is_workflow_branch? val;  workflow.member? val  end
  
  
  def feature_branches;  config_get('gwt.features')  end
  def is_feature_branch? val;  feature_branches.member? val  end
  
end

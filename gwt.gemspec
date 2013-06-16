# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gwt'

Gem::Specification.new do |gem|
  gem.name          = "gwt"
  gem.version       = GWT::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ["Gerard Hickey"]
  gem.email         = ["hickey@kinetic-compute.com"]
  # gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{Git workflow tool}
  gem.homepage      = "https://github.com/hickey/git-workflow-tool"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  # gem.add_dependency 'listen', '~> 0.5.0'
  gem.add_dependency  'git', '~> 1.2.5'
  
  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'rspec', '~> 2.11.0'
  #gem.add_development_dependency 'spork', '~> 1.0.0.rc3'
  #gem.add_development_dependency 'timecop', '~> 0.4.6'
end

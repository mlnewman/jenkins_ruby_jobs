# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jenkins_ruby_jobs/version'

Gem::Specification.new do |gem|
  gem.name          = "jenkins_ruby_jobs"
  gem.version       = Jenkins::VERSION
  gem.authors       = ["Marion Newman"]
  gem.email         = ["marion.newman@gmail.com"]
  gem.description   = %q{Jenkins integration for Ruby}
  gem.summary       = %q{Jenkins integration for Ruby}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "jenkins_api_client", ">= 0.5.0"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", ">= 2.11"
  gem.add_development_dependency "builder"
  gem.add_dependency "httparty"
end
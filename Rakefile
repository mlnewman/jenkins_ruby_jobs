require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'lib/jenkins_ruby_jobs/buildjob'
import "./lib/jenkins_ruby_jobs/tasks/jenkins.rake"
RSpec::Core::RakeTask.new

task :default => :spec
task :test    => :spec
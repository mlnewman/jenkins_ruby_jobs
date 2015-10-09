require "jenkins_ruby_jobs"

SPEC_ROOT = File.join(Jenkins::GEM_ROOT, 'spec')

Dir[File.join(SPEC_ROOT, "support", "**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include RSpecHelpers
end
namespace :jenkins do
  desc 'Create jenkins project'
  task :buildjob, [:username, :password, :config_file] => :environment do |t, args|
    Jenkins.buildjob(args)
  end
end
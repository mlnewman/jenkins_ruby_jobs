require 'jenkins_ruby_jobs/version'
require 'jenkins_ruby_jobs/jenkinsapi'
require 'net/http'
require 'uri'

module Jenkins
  GEM_ROOT = File.join(File.dirname(__FILE__), '../..')

  def self.buildjob(options)        
    # Assumes that you created a jenkins folder inside your applications config directory
    @configuration ||= Configuration.new(options[:config_file] || Rails.root.join('config', 'jenkins', 'jenkins.yml'))
    puts Rails.root.join('config', 'jenkins', 'jenkins.yml')
    jobs_params      = @configuration.params    
    @client = JenkinsApi::Client.new(
      :server_ip   => @configuration.host,
      :server_port => @configuration.port,
      :username    => options[:username] || @configuration.username,      
      :password    => options[:password] || @configuration.password
    )    
    project = {:username => @configuration.username, :password => @configuration.password, :host => @configuration.host, :folder_name => @configuration.folder_name}    
    begin
      client.job.create_project_folder(project)
      jobs_params.each do |job_params|
        Rails.logger.info "Processing jobs for #{project[:folder_name]}" if defined?(Rails)
        client.job.create_jenkins_job(job_params.merge(
          :name     => URI::encode(job_params[:name]),
          :username => @configuration.username,
          :password => @configuration.password,   
          :host     => @configuration.host,
          :folder_name => @configuration.folder_name
        ))
      end 
    rescue => e
      Rails.logger.info "Error creating folder #{project[:folder_name]} : #{e}" if defined?(Rails)
    end  
  end
  def self.client
    @client
  end
  def self.configuration
    @configuration
  end
end

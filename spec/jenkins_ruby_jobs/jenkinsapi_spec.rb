require 'spec_helper'
require 'nokogiri'

describe JenkinsApi::Client::Job do
  before do
    @client = JenkinsApi::Client.new(:server_ip => 'http://aws.jenkins.com')
    @job    = JenkinsApi::Client::Job.new(@client)
    @params = {
      :name                                 => 'job',
      :keep_dependencies                    => true,
      :block_build_when_downstream_building => true,
      :block_build_when_upstream_building   => true,
      :concurrent_build                     => true,
      :scm_provider                         => 'git',
      :scm_url                              => 'git@github.com:mlnewman/jenkins_ruby_jobs.git',
      :scm_branch                           => 'master',
      :shell_command                        => "echo 'Hello World'"
    }
  end
  describe 'xml' do
    let(:xml) { @job.xml_config(@params)}
    let(:builder) { Nokogiri::XML(xml) }

    context 'when getting keepdependencies' do
      subject { builder.xpath("//keepDependencies").first.content }
      it { is_expected.to eq 'true' }
    end
    context 'when getting blockBuildWhenDownstreamBuilding' do
      subject { builder.xpath("//blockBuildWhenDownstreamBuilding").first.content }
      it { is_expected.to eq 'true' }
    end 
    context 'when getting blockBuildWhenUpstreamBuilding' do
      subject { builder.xpath("//blockBuildWhenUpstreamBuilding").first.content }
      it { is_expected.to eq 'true' }
    end
    context 'when getting concurrentBuild' do
      subject { builder.xpath("//concurrentBuild").first.content }
      it { is_expected.to eq 'true' }
    end
    context 'when getting scm_provider' do
      subject { builder.xpath("//scm[@class='hudson.plugins.git.GitSCM']").first }
      it { should_not be_nil }
    end
    context 'when getting scm_url' do
      subject { builder.xpath("//userRemoteConfigs//url").first.content }
      it { is_expected.to eq 'git@github.com:mlnewman/jenkins_ruby_jobs.git' }
    end
    context 'when getting scm_branch' do
      subject { builder.xpath("//hudson.plugins.git.BranchSpec/name").first.content }
      it { is_expected.to eq 'master'}
    end
    context 'when getting shell command' do
      subject { builder.xpath("//hudson.tasks.Shell/command").first.content }
      it { is_expected.to eq "echo 'Hello World'"}
    end
    context 'when getting authorization matrix' do
      subject { builder.xpath("//hudson.security.AuthorizationMatrixProperty").first }
      it { should_not be_nil }
    end
    context 'when getting GitHubPushTrigger' do
      subject { builder.xpath("//com.cloudbees.jenkins.GitHubPushTrigger").first }
      it { should_not be_nil }
    end
    context 'when SCMTrigger' do
      subject { builder.xpath("//hudson.triggers.SCMTrigger").first }
      it { should_not be_nil }
    end  
  end 
end
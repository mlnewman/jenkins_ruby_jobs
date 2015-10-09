require 'spec_helper'
describe Jenkins::Configuration do
  let(:configuration) { double('configuration') }
  context 'get host' do
    it 'returns host' do
      allow(configuration).to receive(:host).and_return("aws.sample.com")
      expect(configuration.host).to eql 'aws.sample.com'
    end
  end
  context 'get username' do
    it 'returns username' do    
      allow(configuration).to receive(:username).and_return("username")
      expect(configuration.username).to eql 'username'
    end
  end
  context 'get password' do
    it 'returns password' do    
      allow(configuration).to receive(:password).and_return("password")
      expect(configuration.password).to eql 'password'
    end
  end    
end

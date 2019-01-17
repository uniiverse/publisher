require 'spec_helper'

RSpec.describe Publisher::Config::GcloudConfig do
  let(:instance) { Publisher::Config::GcloudConfig.instance }
  let(:credentials) {
    {
      'type'=>'service_account',
      'project_id'=>'foobar',
      'private_key_id'=>'some_private_key',
      'private_key'=>"-----BEGIN PRIVATE KEY-----\nfoobar\n-----END PRIVATE KEY-----\n",
      'client_email'=>'me@foobar.iam.gserviceaccount.com',
      'client_id'=>'my_client_id',
      'auth_uri'=>'https://accounts.google.com/o/oauth2/auth',
      'token_uri'=>'https://accounts.google.com/o/oauth2/token',
      'auth_provider_x509_cert_url'=>'https://www.googleapis.com/oauth2/v1/certs',
      'client_x509_cert_url'=>'https://www.googleapis.com/robot/v1/metadata/x509/foobar.iam.gserviceaccount.com'}
  }

  it 'should be a singleton' do
    expect(
      Publisher::Config::GcloudConfig.included_modules.include?(Singleton)
    ).to be true
  end

  describe '.configure' do
    it 'should throw a NoBlockGivenException when no block is given' do
      expect {
        Publisher::Config::GcloudConfig.configure
      }.to raise_exception(Publisher::NoBlockGivenException)
    end

    it 'should successfully initialize a config instance' do
      config = Publisher::Config::GcloudConfig.configure do |config|
        config.project_id = 'my_project_id'
        config.credentials = credentials
      end

      expect(config.project_id).to eq('my_project_id')
    end
  end

  describe '#initialize' do
    before do
      expect_any_instance_of(Publisher::Config::GcloudConfig).to receive(:prepare_pubsub).once
    end

    Publisher::Config::GcloudConfig.instance
  end

  describe '#valid?' do
    it 'should return false if project_id or credentials is missing' do
      instance.project_id = 'foobar'
      instance.credentials = nil
      expect(instance.valid?).to be false

      instance.project_id = nil
      instance.credentials = 'path/to/keyfile.json'
      expect(instance.valid?).to be false
    end

    it 'should return true if project_id and credentials are set' do
      instance.project_id = 'foobar'
      instance.credentials = 'path/to/keyfile.json'
      expect(instance.valid?).to be true
    end
  end

  describe '.project_id' do
    it 'returns the current gcloud project id' do
      instance.project_id = 'foobar'
      expect(Publisher::Config::GcloudConfig.project_id).to eq 'foobar'
    end
  end

  describe '.credentials' do
    it 'returns the current gcloud credentials' do
      instance.credentials = 'foobar'
      expect(Publisher::Config::GcloudConfig.credentials).to eq 'foobar'
    end
  end

  describe '.router' do
    it 'returns the current gcloud router' do
      instance.router = DummyRouter
      expect(Publisher::Config::GcloudConfig.router).to be DummyRouter
    end
  end
end

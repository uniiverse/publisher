require 'spec_helper.rb'

RSpec.describe Publisher do
  it 'has a version number' do
    expect(Publisher::VERSION).not_to be nil
  end

  describe '.configure' do
    it 'returns an instance of Publisher::Config::MainConfig' do
      instance = Publisher.configure do |config|
        config.gcloud do |gcloud_config|
          gcloud_config.project_id = 'project_id'
          gcloud_config.credentials = {}
          gcloud_config.router = DummyRouter
        end
      end
      expect(instance).to be_a(Publisher::Config::MainConfig)
    end

    it 'raises an exception when no block is given' do
      expect { Publisher::configure }.to raise_error(Publisher::NoBlockGivenException)
    end
  end
end

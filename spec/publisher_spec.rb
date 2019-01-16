require 'spec_helper.rb'

RSpec.describe Publisher do
  it 'has a version number' do
    expect(Publisher::VERSION).not_to be nil
  end

  describe '.configure' do
    it 'returns an instance of Publisher::Config::MainConfig' do
      instance = Publisher.configure do |config|
      end
      expect(instance).to be_a(Publisher::Config::MainConfig)
    end

    it 'raises an exception when no block is given' do
      expect { Publisher::configure }.to raise_error(Publisher::NoBlockGivenException)
    end
  end
end

require 'spec_helper'

RSpec.describe Publisher::Config::MainConfig do
  let(:instance) { Publisher::Config::MainConfig.instance }

  it 'returns a Config instance' do
    expect(instance)
      .to be_a(Publisher::Config::MainConfig)
  end

  it 'returns a singleton' do
    expect(instance)
      .to eq(instance)
  end

  describe 'remove_logger!' do
    it 'sets the logger to nil' do
      instance.send :remove_logger!
      expect(instance.logger).to be_nil
      instance.logger = Logger.new(STDOUT)
    end
  end

  describe 'logger' do
    it 'uses a STDOUT logger by default' do
      expect(instance.logger.class).to eq(Logger)
    end

    it 'uses Rails.logger if defined' do
      class Rails
        @logger = nil

        class << self
          attr_accessor :logger
        end
      end

      logger = Logger.new(STDOUT)
      Rails.logger = logger

      instance.send :remove_logger!
      instance.send(:init_logger)
      expect(instance.logger).to eq(logger)
      Object.send :remove_const, :Rails
    end
  end
end

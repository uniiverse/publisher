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
end

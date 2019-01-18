require 'spec_helper'

RSpec.describe Publisher::Agent do
  let(:payload) { { id: 123, action: :create } }
  let(:topic_name) { :foobar }
  let(:instance) { Publisher::Agent.new(payload, topic_name) }

  describe 'attributes' do
    it { expect(instance).to have_attr_accessor(:payload) }
    it { expect(instance).to have_attr_accessor(:topic_name) }
    it { expect(instance).to have_attr_reader(:pubsub) }
  end

  describe '.initialize' do
    it 'sets payload and topic_name' do
      expect_any_instance_of(Publisher::Agent).to receive(:init_pubsub)
      agent = Publisher::Agent.new(payload, topic_name)
      expect(agent.payload).to eq(payload)
      expect(agent.topic_name).to eq(topic_name)
    end
  end

  describe '.init_pubsub' do
    it 'creates an instance of Publisher::Gcloud::Pubsub.new with the current topic_name' do
      pubsub = instance.init_pubsub
      expect(pubsub).to be_a Publisher::Gcloud::Pubsub
      expect(pubsub.topic_name).to eq topic_name
    end
  end

  describe '.publish_to_pubsub' do
    it 'publish synchronously when async is false' do
      expect(instance.pubsub).to receive_message_chain(:topic, :publish).with(payload)
      instance.publish_to_pubsub
    end

    it 'publish asynchronously when async is true' do
      pubsub_double = double(Google::Cloud::Pubsub)
      topic_double = double(Google::Cloud::Pubsub::Topic)
      allow(Google::Cloud::Pubsub).to receive(:new).and_return(pubsub_double)
      allow(pubsub_double).to receive(:topic).and_return(topic_double)
      allow(topic_double).to receive(:publish_async).with(payload)

      expect(topic_double).to receive(:publish_async).with(payload)
      expect(topic_double).to receive_message_chain(:async_publisher, :stop, :wait!)
      instance.publish_to_pubsub true
    end
  end
end

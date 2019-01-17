require 'spec_helper'

RSpec.describe Publisher::Extensions::Pubsub do
  let(:model) { DummyModel.new }
  describe '#publish_to_pubsub' do
    it 'publishes a message synchronously' do
      DummyController.send :include, Publisher::Extensions::Pubsub
      controller = DummyController.new
      expect_any_instance_of(DummyRouter).to receive(:initialize).with(model, :create).and_call_original
      expect(::Publisher::Agent).to receive(:new).with({ :action => :create }, :dummy_model).and_call_original
      expect_any_instance_of(::Publisher::Agent).to receive(:publish_to_pubsub).with(false).and_call_original

      controller.publish_to_pubsub(model, :create)
    end
  end

  describe '#publish_to_pubsub_async' do
    it 'publishes a message asynchronously' do
      DummyController.send :include, Publisher::Extensions::Pubsub
      controller = DummyController.new
      expect_any_instance_of(DummyRouter).to receive(:initialize).with(model, :create).and_call_original
      expect(::Publisher::Agent).to receive(:new).with({ :action => :create }, :dummy_model).and_call_original
      expect_any_instance_of(::Publisher::Agent).to receive(:publish_to_pubsub).with(true).and_call_original

      controller.publish_to_pubsub_async(model, :create)
    end
  end
end

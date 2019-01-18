require 'spec_helper'

RSpec.describe Publisher::Extensions::Models::Base do
  let(:dummy_class) { Class.new { include Publisher::Extensions::Models::Base } }

  describe '#publish_create_message' do
    it 'calls publish_message with action :create' do
      obj = dummy_class.new
      expect(obj).to receive(:publish_message).with(:create)
      obj.send :publish_create_message
    end
  end

  describe '#publish_destroy_message' do
    it 'calls publish_message with action :destroy' do
      obj = dummy_class.new
      expect(obj).to receive(:publish_message).with(:destroy)
      obj.send :publish_destroy_message
    end
  end

  describe '#publish_update_message' do
    it 'calls publish_message with action :update' do
      obj = dummy_class.new
      expect(obj).to receive(:publish_message).with(:update)
      obj.send :publish_update_message
    end
  end
end

require 'spec_helper'

RSpec.describe Publisher::Extensions::Models::Mongoid do
  let(:dummy_class) { Class.new { include Mongoid::Document; include Publisher::Extensions::Models::Mongoid } }
  let(:instance) { dummy_class.new }

  describe 'callbacks' do
    it 'defines after callbacks for create, destroy, and update' do
      # create
      after_create_callbacks = dummy_class._create_callbacks.select { |cb| cb.kind == :after }
      expect(after_create_callbacks.size).to eq 1
      expect(after_create_callbacks.collect(&:filter)).to include(:publish_create_message)

      # destroy
      after_destroy_callbacks = dummy_class._destroy_callbacks.select { |cb| cb.kind == :after }
      expect(after_destroy_callbacks.size).to eq 1
      expect(after_destroy_callbacks.collect(&:filter)).to include(:publish_destroy_message)

      # update
      after_update_callbacks = dummy_class._update_callbacks.select { |cb| cb.kind == :after }
      expect(after_update_callbacks.size).to eq 1
      expect(after_update_callbacks.collect(&:filter)).to include(:publish_update_message)
    end
  end
end

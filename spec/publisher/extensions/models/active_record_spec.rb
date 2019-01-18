require 'spec_helper'

RSpec.describe Publisher::Extensions::Models::ActiveRecord do
  let(:dummy_class) { Class.new(ActiveRecord::Base) { include Publisher::Extensions::Models::ActiveRecord } }

  describe 'callbacks' do
    it 'defines after commit callbacks for create, destroy, and update' do
      after_create_callbacks = dummy_class._commit_callbacks.select { |cb| cb.kind == :after }
      expect(after_create_callbacks.size).to eq 3
      expect(after_create_callbacks.collect(&:filter)).to include(:publish_create_message, :publish_destroy_message, :publish_update_message)
    end
  end
end

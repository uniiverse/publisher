module Publisher
  module Extensions
    module Models
      #
      # ActiveRecord callbacks extensions. Include this module to automatically
      # publish messages to Pubsub after commit on create, destroy, and update.
      #
      module ActiveRecord
        extend ActiveSupport::Concern
        include Publisher::Extensions::Models::Base

        included do
          after_commit :publish_create_message, on: :create
          after_commit :publish_destroy_message, on: :destroy
          after_commit :publish_update_message, on: :update
        end
      end
    end
  end
end

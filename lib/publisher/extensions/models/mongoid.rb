module Publisher
  module Extensions
    module Models
      #
      # Mongoid callbacks extensions. Include this module to automatically
      # publish messages to Pubsub after commit on create, destroy, and update.
      #
      module Mongoid
        extend ActiveSupport::Concern
        include Publisher::Extensions::Models::Base

        included do
          after_create :publish_create_message
          after_destroy :publish_destroy_message
          after_update :publish_update_message
        end
      end
    end
  end
end

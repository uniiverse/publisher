module Publisher
  module Extensions
    module Models
      #
      # Common module methods used by AR and Mongoid model extensions.
      #
      module Base
        extend ActiveSupport::Concern
        include Publisher::Extensions::Pubsub

        included do
          private

          #
          # Publish a pubsub message after create.
          #
          # @return [Google::Cloud::Pubsub::Message] pubsub message or nil.
          #
          def publish_create_message
            publish_message :create
          end

          #
          # Publish a pubsub message after destroy.
          #
          # @return [Google::Cloud::Pubsub::Message] pubsub message or nil.
          #
          def publish_destroy_message
            publish_message :destroy
          end

          #
          # Publish a pubsub message after update.
          #
          # @return [Google::Cloud::Pubsub::Message] pubsub message or nil.
          #
          def publish_update_message
            publish_message :update
          end

          #
          # Publish messages to pubsub.
          #
          # @param [String] action create, destroy, or update.
          #
          # @return [Google::Cloud::Pubsub::Message] pubsub message or nil.
          #
          def publish_message(action)
            return if ENV['RACK_ENV'] == 'test' || ENV['RAILS_ENV'] == 'test'
            publish_to_pubsub(self, action)
          end
        end
      end
    end
  end
end

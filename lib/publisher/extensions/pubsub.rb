module Publisher
  module Extensions
    #
    # Pubsub extension method that can be included by clients to publish events.
    #
    module Pubsub
      extend ActiveSupport::Concern

      #
      # Publish a message to Pubsub synchronously.
      #
      # @param [ActiveModel] model An active model instance.
      # @param [String] action model action performed. Ex: :update, :create
      #
      def publish_to_pubsub(model, action)
        publish(model, action)
      end

      #
      # Publish a message to Pubsub asynchronously.
      #
      # @param [ActiveModel] model An active model instance.
      # @param [String] action model action performed. Ex: :update, :create
      #
      def publish_to_pubsub_async(model, action)
        publish(model, action, true)
      end

      private

      def publish(model, action, async = false)
        data = Publisher::Config::GcloudConfig.router.new(model, action).route
        if data.present? && data.dig(:topic_name).present? && data.dig(:payload).present?
          ::Publisher::Agent
            .new(data[:payload], data[:topic_name])
            .publish_to_pubsub(async)
        end
      end
    end
  end
end

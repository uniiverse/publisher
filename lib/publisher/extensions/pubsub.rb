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
        data = Publisher::Config::GcloudConfig.router.new(model, action).route
        if data.include?(:topic_name) && data.include?(:payload)
          ::Publisher::Agent
            .new(data[:payload], action, data[:topic_name])
            .publish_to_pubsub(false)
        end
      end

      #
      # Publish a message to Pubsub asynchronously.
      #
      # @param [ActiveModel] model An active model instance.
      # @param [String] action model action performed. Ex: :update, :create
      #
      def publish_to_pubsub_async(model, action)
        data = Publisher::Config::GcloudConfig.router.new(model, action).route
        if data.include?(:topic_name) && data.include?(:payload)
          ::Publisher::Agent
            .new(data[:payload], action, data[:topic_name])
            .publish_to_pubsub(true)
        end
      end
    end
  end
end

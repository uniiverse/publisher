module Publisher
  #
  # A Pubsub agent that publishes messages to Pubsub.
  #
  class Agent
    attr_accessor :payload, :action, :topic_name
    attr_reader :pubsub

    #
    # Constructor.
    #
    # @param [Hash] payload pubsub attributes.
    # @param [String] action the performed action, ex: :create.
    # @param [String] topic_name name of pubsub topic to publish to.
    #
    def initialize(payload, action, topic_name)
      self.payload = payload
      self.action = action
      self.topic_name = topic_name
      init_pubsub
    end

    #
    # Create a new instance of Publisher::Gcloud::Pubsub
    #
    # @return [Publisher::Gcloud::Pubsub] pubsub instance
    #
    def init_pubsub
      @pubsub = Publisher::Gcloud::Pubsub.new(topic_name)
    end

    #
    # Publishes a new message to pubsub
    #
    # @param [Boolean] async use async publishing or not.
    #
    def publish_to_pubsub(async = false)
      begin
        if async == true
          @pubsub.topic.publish_async payload
        else
          @pubsub.topic.publish payload
        end
      rescue => ex
        # Raven.capture_exception(ex)
        Rails.logger.error ex
      end
    end
  end
end

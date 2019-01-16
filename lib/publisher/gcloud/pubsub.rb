require 'google/cloud/pubsub'

module Publisher
  module Gcloud
    #
    # Provides access to a Google Cloud Pubsub topic.
    #
    class Pubsub
      attr_reader :topic_name

      #
      # Constructor.
      #
      # @param [String] topic_name name of an existing pubsub topic
      #
      def initialize(topic_name)
        @topic_name = topic_name
      end

      #
      # Returns an instance of Google::Cloud::Pubsub
      #
      # @return [Google::Cloud::Pubsub] pubsub instance
      #
      def pubsub
        return @pubsub unless @pubsub.nil?

        begin
          @pubsub = Google::Cloud::Pubsub.new(
            project: Publisher::Config::GcloudConfig.project_id,
            keyfile: Publisher::Config::GcloudConfig.credentials
          )
        rescue => ex
          Raven.capture_exception(ex)
          Rails.logger.error ex
        end
      end

      #
      # Returns an instance of Google::Cloud::Pubsub::Topic.
      #
      # @return [Google::Cloud::Pubsub::Topic] pubsub topic instance.
      #
      def topic
        return @topic unless @topic.nil?

        begin
          @topic = pubsub.topic topic_name
        rescue => ex
          Raven.capture_exception(ex)
          Rails.logger.error ex
        end
      end
    end
  end
end

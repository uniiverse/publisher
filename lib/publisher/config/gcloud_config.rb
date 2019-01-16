require 'google/cloud/pubsub'

module Publisher
  module Config
    #
    # Gcloud config class used by clients to configure pubsub credentials.
    #
    # @example configure credentials
    #   Publisher.configure do |config|
    #     config.gcloud do |gcloud_config|
    #       gcloud_config.project_id = AppConfig.instance.gcloud_project_id
    #       gcloud_config.credentials = credentials
    #       gcloud_config.router = Events::Pubsub::Router
    #     end
    #   end
    #
    class GcloudConfig
      include Singleton
      attr_accessor :project_id, :credentials, :router

      #
      # DSL entry point.
      #
      # @return [Publisher::Config::GcloudConfig] gcloud config instance.
      #
      def self.configure(&block)
        raise NoBlockGivenException unless block_given?

        instance = GcloudConfig.instance
        instance.instance_eval(&block)

        instance
      end

      #
      # Gcloud project ID.
      #
      # @return [String] project id.
      #
      def self.project_id
        GcloudConfig.instance.project_id
      end

      #
      # Gcloud credentails hash.
      #
      # @return [Hash] Service account credentials.
      #
      def self.credentials
        GcloudConfig.instance.credentials
      end

      #
      # Router class defined as defined by the client.
      #
      # @return [Class] router class.
      #
      def self.router
        GcloudConfig.instance.router
      end

      #
      # Ensures that both project id and credentials hash object are set.
      #
      # @return [Boolean] validation result.
      #
      def valid?
        !project_id.nil? && !credentials.nil?
      end
    end
  end
end

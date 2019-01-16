require 'publisher/config/gcloud_config'

module Publisher
  module Config
    #
    # Main gem configuration class
    #
    class MainConfig
      include Singleton
      attr_accessor :logger, :enable_sentry

      def initialize
        @enable_sentry = false

        init_logger
        init_sentry
      end

      #
      # DSL entry point.
      #
      # @return [Publisher::Config::MainConfig] main config instance.
      #
      def self.configure(&block)
        raise NoBlockGivenException unless block_given?

        instance = MainConfig.instance
        instance.instance_eval(&block)

        instance
      end

      #
      # Enable or disables sentry exceptions logging.
      #
      # @param [Boolean] use_sentry toggle value
      #
      # @return [Boolean] sentry config state
      #
      def enable_sentry=(use_sentry)
        @enable_sentry = use_sentry
      end

      #
      # Configure Pubsub
      #
      # @return [Publisher::Config::GcloudConfig] gcloud config instance.
      #
      def gcloud(&block)
        GcloudConfig.configure(&block)
      end

      private

      def remove_logger!
        @logger = nil
      end

      def init_logger
        if defined?(Rails) && defined?(Rails.logger)
          @logger = Rails.logger
        else
          @logger = Logger.new(STDOUT)
        end
      end

      def init_sentry
        # @dispatcher.enable_sentry = @enable_sentry
      end
    end
  end
end

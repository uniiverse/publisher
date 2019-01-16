require 'publisher/config/gcloud_config'

module Publisher
  module Config
    #
    # Main gem configuration class
    #
    class MainConfig
      include Singleton
      attr_accessor :logger

      def initialize
        init_logger
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
    end
  end
end

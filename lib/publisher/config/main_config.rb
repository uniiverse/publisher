require 'publisher/config/gcloud_config'

module Publisher
  module Config
    #
    # Main gem configuration class
    #
    class MainConfig
      include Singleton

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
    end
  end
end

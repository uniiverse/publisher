require 'publisher/version'
require 'active_support'
require 'active_support/core_ext'
require 'singleton'
require 'publisher/config/main_config'
require 'publisher/extensions/pubsub'
require 'publisher/gcloud/pubsub'
require 'publisher/agent'

module Publisher
  def self.configure(&block)
    raise NoBlockGivenException unless block_given?

    Config::MainConfig.configure(&block)
  end

  class NoBlockGivenException < RuntimeError; end
end

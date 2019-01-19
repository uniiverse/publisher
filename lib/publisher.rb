require 'publisher/version'
require 'active_support'
require 'active_support/core_ext'
require 'singleton'
require 'publisher/config/main_config'
require 'publisher/extensions/pubsub'
require 'publisher/extensions/models/base'
require 'publisher/extensions/models/active_record'
require 'publisher/extensions/models/mongoid'
require 'publisher/gcloud/pubsub'
require 'publisher/agent'

#
# Gem configuration / entry point
#
module Publisher
  def self.configure(&block)
    raise NoBlockGivenException unless block_given?

    Config::MainConfig.configure(&block)
  end

  class NoBlockGivenException < RuntimeError; end
end

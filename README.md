# Publisher

[![CircleCI](https://circleci.com/gh/uniiverse/publisher.svg?style=svg&circle-token=209055ff2f326a7794b73db18518ca597f6192a0)](https://circleci.com/gh/uniiverse/publisher)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A library that facilitates publishing events to GCloud Pubsub topics.

## Usage

Add the following to a Rails initializer

```ruby
project_id = AppConfig.instance.gcloud_project_id
credentials = ...

Publisher.configure do |config|
  config.gcloud do |gcloud_config|
    gcloud_config.project_id = AppConfig.instance.gcloud_project_id
    gcloud_config.credentials = credentials
    gcloud_config.router = Events::Pubsub::Router
  end
end
```

Events router class example:

```ruby
module Events
  module Pubsub
    class Router
      attr_accessor :model, :action

      def initialize(model, action)
        self.model = model
        self.action = action
      end

      def route
        {
          topic_name: "app_#{Rails.env}".to_sym,
          payload: {
          id: model.id,
          action: action
          eventTime: Time.now.in_time_zone('UTC').to_i
          }
        }
      end
    end
  end
end
```

To publish message include the module `Publisher::Extensions::Pubsub` and publish messages like so:

```ruby
include Publisher::Extensions::Pubsub
...
# Publish synchronously
publish_to_pubsub(User.last, :update)
# Publish asynchronously
publish_to_pubsub_async(User.last, :update)
```

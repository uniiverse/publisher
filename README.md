# Publisher

A library that facilitates publishing events to GCloud Pubsub topics.

## Usage

Add the following to a Rails initializer

```ruby
project_id = AppConfig.instance.gcloud_project_id
decoded_credentials = Base64.strict_decode64(
  AppConfig.instance.data_pipelines
)
credentials = JSON.parse(decoded_credentials)

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

       # Depending on class being updated generate and send correct topic_name, payload, action to pubsum message publisher
      def route(async = false)
        topic_name = nil
        payload = nil
        case model.class.name
        when 'Commission'
          topic_name = :dwh_listing_expired
          payload = { id: model.id.to_s, created_at: model.created_at.to_i, action: action }
        end

        { topic_name: topic_name, payload: payload }
      end
    end
  end
end
```

To publish message include the module `Publisher::Extensions::Pubsub` and publish messages like so:

```ruby
include Publisher::Extensions::Pubsub
...
publish_to_pubsub_async(Commission.last, :update)
```

require 'spec_helper'

class DummyController
end

class DummyModel
end

class DummyRouter
  attr_accessor :model, :action

  def initialize(model, action)
    @model = model
    @action = action
  end

  def route
    topic_name = nil
    payload = nil
    case model.class.name
    when 'DummyModel'
      topic_name = :dummy_model
      payload = { action: action }
    end

    { topic_name: topic_name, payload: payload }
  end
end

credentials = {
    'type' => 'service_account',
    'project_id' => 'foobar',
    'private_key_id' => 'some_private_key',
    'private_key'=>"-----BEGIN PRIVATE KEY-----\nfoobar\n-----END PRIVATE KEY-----\n",
    'client_email' => 'me@foobar.iam.gserviceaccount.com',
    'client_id' => 'my_client_id',
    'auth_uri' => 'https://accounts.google.com/o/oauth2/auth',
    'token_uri' => 'https://accounts.google.com/o/oauth2/token',
    'auth_provider_x509_cert_url' => 'https://www.googleapis.com/oauth2/v1/certs',
    'client_x509_cert_url' => 'https://www.googleapis.com/robot/v1/metadata/x509/foobar.iam.gserviceaccount.com'
  }

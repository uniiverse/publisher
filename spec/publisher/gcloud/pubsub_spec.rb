require 'spec_helper'

RSpec.describe Publisher::Gcloud::Pubsub do
  before do
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

    Publisher.configure do |config|
      config.gcloud do |gcloud_config|
        gcloud_config.project_id = 'project_id'
        gcloud_config.credentials = credentials
        gcloud_config.router = DummyRouter
      end
    end

    @instance = Publisher::Gcloud::Pubsub.new(:foobar)
  end
  describe 'attributes' do
    it { expect(@instance).to have_attr_reader(:topic_name) }
  end

  describe '.initialize' do
    it 'sets the topic_name' do
      expect(@instance.topic_name).to eq :foobar
    end
  end

  describe '#pubsub' do
    it 'returns an instance of Google::Cloud::Pubsub' do
      pubsub_double = double(Google::Cloud::Pubsub)
      allow(Google::Cloud::Pubsub).to receive(:new).and_return(pubsub_double)
      pubsub = @instance.pubsub
      expect(@instance.pubsub).not_to be_nil
      expect(@instance.pubsub.object_id).to eq pubsub.object_id
    end
  end

  describe '#topic' do
    it 'returns an instance of Google::Cloud::Pubsub' do
      pubsub_double = double(Google::Cloud::Pubsub)
      topic_double = double(Google::Cloud::Pubsub::Topic)
      allow(Google::Cloud::Pubsub).to receive(:new).and_return(pubsub_double)
      allow(pubsub_double).to receive(:topic).and_return(topic_double)
      topic = @instance.topic
      expect(@instance.topic).not_to be_nil
      expect(@instance.topic.object_id).to eq topic.object_id
    end
  end
end

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

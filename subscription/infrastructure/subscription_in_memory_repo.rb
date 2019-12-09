# frozen_string_literal: true

class SubscriptionInMemoryRepo

  def self.subscriptions
    @subscriptions = Hash.new
  end

  def save(subscription)
    self.class.subscriptions[subscription.id] = subscription
  end

  def find_by
    self.class.subscription[subscription.id]
  end
end

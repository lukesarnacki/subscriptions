# frozen_string_literal: true

require_relative '../subscription/domain/subscription'
require_relative '../subscription/infrastructure/subscription_in_memory_repo'

describe PauseSubscription do
  it 'fails when subscription is not found' do
    subscription = Subscription.new()
  end

end

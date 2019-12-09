# frozen_string_literal: true

require_relative '../../common/result'

class PauseSubscription
  attr_accessor :repo
  protected :repo

  def initialize(repo: SubscriptionInMemoryRepo.new)
    self.repo = repo
  end

  def call(subscription, subscriber)
    unless subscription.owned_by(subscriber)
      return Result.failure("Subscription with id #{subscription.id} is not owned by subscriber with id #{subscriber.id}")
    end
    if subscription.nil?
      return Result.failre("Subscription with id #{subscription.id} doesn't exist")
    end

    subscription = repo.find_by(subscription)
    result = subscription.pause
    repo.save(subscription)
    result
  end
end

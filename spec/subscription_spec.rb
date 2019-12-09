# frozen_string_literal: true

require_relative '../app/domain/subscription'
require 'timecop'
require 'byebug'

describe Subscription do
  subject(:subscription) { Subscription.new }

  it 'activates new subscription' do
    expect(subscription.activate).to be_success
  end

  it 'pauses activated subscription' do
    subscription.activate
    expect(subscription.pause).to be_success
    expect(subscription).to be_paused
  end

  it 'fails on pausing inactive subscription' do
    expect(subscription.pause).to be_failure
  end

  it 'fails on pause when 2 pauses are used' do
    subscription.activate

    2.times do
      expect(subscription.pause).to be_success
      Timecop.travel Date.today + 11
      expect(subscription.resume).to be_success
    end

    expect(subscription.pause).to be_failure
  end

  it 'resumes subscription when it is paused' do
    subscription.activate
    subscription.pause
    expect(subscription.resume).to be_success
    expect(subscription).to be_active
  end

  it 'marks subscription as past due' do
    expect(subscription.mark_as_past_due).to be_success
    expect(subscription).to be_past_due
  end
end

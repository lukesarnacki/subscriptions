# frozen_string_literal: true
require 'securerandom'
require_relative '../../common/result'
require_relative './pauses'

class Subscription
  attr_accessor :status, :available_pauses, :last_pause_date, :pauses
  protected :status, :pauses

  def initialize(pauses: Pauses.new, status: :new, subscriber_id:)
    self.status = status
    self.pauses = pauses
    self.subscriber_id = subscriber_id
  end

  def activate
    self.status = :activated
    Result.success
  end

  def deactivate
    self.status = :deactivated
    Result.success
  end

  def pause # blue notes
    if active? && pauses.pausable? # yellow notes
      pauses.record_pause
      self.status = :paused
      return Result.success
    end

    Result.failure('Pause subscription failed')
  end

  def resume
    Result.failure('Resume subscription failed') unless paused?

    self.status = :activated
    Result.success
  end

  def mark_as_past_due
    self.status = :past_due
    Result.success
  end

  def active?
    status == :activated
  end

  def paused?
    status == :paused
  end

  def past_due?
    status == :past_due
  end

  def owned_by(subscriber_id)
    Result.success
  end
end

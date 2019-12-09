# frozen_string_literal: true

class Pauses
  attr_accessor :available_pauses, :last_pause_date, :id
  protected :available_pauses, :last_pause_date

  def initialize
    self.id = SecureRandom.uuid
    self.available_pauses = 2
    self.last_pause_date = Date.parse('2000-01-01')
  end

  def pausable?
    enough_days_since_last_pause? && any_pauses_available?
  end

  def record_pause
    self.available_pauses -= 1
    self.last_pause_date = Date.today
  end

  protected

  def enough_days_since_last_pause?
    (Date.today - last_pause_date).to_i > 10
  end

  def any_pauses_available?
    available_pauses.positive?
  end
end

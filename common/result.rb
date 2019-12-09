# frozen_string_literal: true

class Result
  class << self
    def success
      OpenStruct.new(success?: true, failure?: false)
    end

    def failure(reason)
      OpenStruct.new(success?: false, failure?: true, reason: reason)
    end
  end
end

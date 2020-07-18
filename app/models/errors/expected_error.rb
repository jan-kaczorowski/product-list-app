# frozen_string_literal: true

module Errors
  class ExpectedError < StandardError
    ERROR_STATUSES = {
      ActiveRecord::RecordInvalid => 422,
      ActionController::ParameterMissing => 422,
      ActiveRecord::RecordNotFound => 404
    }.freeze

    def initialize(error)
      @error = error
    end

    attr_reader :error

    def json_message
      {
        data: {
          error: error.class.name.upcase.gsub('::', '.'),
          message: error.message.upcase
                        .gsub(/\: /, ':')
                        .gsub(/\s/, '.')
                        .gsub(/\'/, ''),
          status: status
        }
      }
    end

    def status
      ERROR_STATUSES[error.class]
    end
  end
end

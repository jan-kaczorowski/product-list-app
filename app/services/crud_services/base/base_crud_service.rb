# frozen_string_literal: true

module CrudServices
  module Base
    class BaseCrudService
      include Dry::Transaction::Operation
      MUST_BE_TRANSACTIONAL = false
      EXPECTED_ERRORS = Errors::ExpectedError::ERROR_STATUSES.keys

      def call
        if self.class::MUST_BE_TRANSACTIONAL
          ActiveRecord::Base.transaction do
            process!
          end
        else
          process!
        end
      rescue *EXPECTED_ERRORS => e
        raise Errors::ExpectedError, e
      rescue StandardError => e
        # maybe log error to Sentry or sth
        raise e
      end
    end
  end
end

module CrudServices
  module Base
    class BaseCrudService
      include Dry::Transaction::Operation

      EXPECTED_ERRORS = Errors::ExpectedError::ERROR_STATUSES.keys
    end
  end
end

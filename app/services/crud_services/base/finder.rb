require "dry/transaction/operation"

module CrudServices
  module Base
    class Finder < BaseCrudService
      SUCCESS_STATUS = 200

      def initialize(resource_klass:, id:)
        @resource_klass = resource_klass
        @id = id
      end

      attr_reader :id, :resource_klass

      def call
        Success(
          data: resource,
          status: SUCCESS_STATUS
        )
      rescue *EXPECTED_ERRORS => e
        raise Errors::ExpectedError, e
      rescue StandardError => e
        # maybe log error to Sentry or sth
        raise e
      end

      private

      def resource
        resource_klass.find(id)
      end
    end
  end
end

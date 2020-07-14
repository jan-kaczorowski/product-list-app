require "dry/transaction/operation"

module CrudServices
  module Base
    class Updater < BaseCrudService
      SUCCESS_STATUS = 200

      def initialize(resource_klass:, params:)
        @resource_klass = resource_klass
        @id = params.delete(:id)
        @attributes = params.delete(:attributes)
      end

      attr_reader :params, :id, :attributes, :resource_klass

      def call
        resource.update!(attributes)
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

require "dry/transaction/operation"

module CrudServices
  module Base
    class Updater
      include Dry::Transaction::Operation

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
      rescue StandardError => e
        Failure(
          error: e
        )
      end

      private

      def resource
        resource_klass.find(id)
      end
    end
  end
end

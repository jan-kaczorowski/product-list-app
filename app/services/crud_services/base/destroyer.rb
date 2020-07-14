require "dry/transaction/operation"

module CrudServices
  module Base
    class Destroyer
      include Dry::Transaction::Operation

      SUCCESS_STATUS = 204

      def initialize(resource_klass:, id:)
        @resource_klass = resource_klass
        @id = id
      end

      attr_reader :resource_klass, :id

      def call
        resource.destroy!
        Success(
          data: {},
          status: SUCCESS_STATUS
        )
      rescue StandardError => e
        Failure(
          error: e
        )
      end

      private

      def resource
        Product.find(@id)
      end
    end
  end
end

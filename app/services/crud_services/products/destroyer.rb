require "dry/transaction/operation"

module CrudServices
  module Products
    class Destroyer
      include Dry::Transaction::Operation

      SUCCESS_STATUS = 204

      def initialize(id)
        @id = id
      end

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

      def resource
        Product.find(@id)
      end
    end
  end
end

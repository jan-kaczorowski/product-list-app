
require "dry/transaction/operation"

module CrudServices
  module Products
    class Updater
      include Dry::Transaction::Operation

      SUCCESS_STATUS = 200

      def initialize(params)
        @id = params.delete(:id)
        @attributes = params.delete(:attributes)
      end

      attr_reader :params, :id, :attributes

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

      def resource
        Product.find(id)
      end
    end
  end
end


require "dry/transaction/operation"

module CrudServices
  module Products
    class Creator
      include Dry::Transaction::Operation

      SUCCESS_STATUS = 201

      def initialize(params)
        @params = params
      end

      attr_reader :params

      def call
        resource = Product.create!(params)
        Success(
          data: resource,
          status: SUCCESS_STATUS
        )
      rescue StandardError => e
        Failure(
          error: e
        )
      end
    end
  end
end

require "dry/transaction/operation"

module CrudServices
  module Products
    class Fetcher
      include Dry::Transaction::Operation

      SUCCESS_STATUS = 200

      def call
        data = Product.all
        Success(
          data: Product.all,
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

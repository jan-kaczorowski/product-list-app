require "dry/transaction/operation"

module CrudServices
  module Products
    class Tagger
      include Dry::Transaction::Operation

      SUCCESS_STATUS = 200

      def initialize(id:, tag_name:)
        @id = id
        @tag_name = tag_name
      end

      attr_reader :id, :tag_name

      def call
        resource.add_tag!(tag_name)
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

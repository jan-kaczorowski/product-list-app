
require "dry/transaction/operation"

module CrudServices
  module Base
    class Finder
      include Dry::Transaction::Operation

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
      rescue StandardError => e
        Failure(
          error: e
        )
      end

      def resource
        resource_klass.find(id)
      end
    end
  end
end


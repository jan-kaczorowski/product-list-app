require "dry/transaction/operation"

module CrudServices
  module Base
    class Creator
      include Dry::Transaction::Operation

      SUCCESS_STATUS = 201

      def initialize(resource_klass:, params:)
        @resource_klass = resource_klass
        @params = params
      end

      attr_reader :resource_klass, :params

      def call
        resource = resource_klass.create!(params)

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

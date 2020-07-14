# frozen_string_literal: true

require 'dry/transaction/operation'

module CrudServices
  module Base
    class Fetcher < BaseCrudService
      SUCCESS_STATUS = 200

      def initialize(resource_klass:, serialized_relationships:)
        @resource_klass = resource_klass
        @serialized_relationships = serialized_relationships
      end

      attr_reader :resource_klass, :serialized_relationships

      def process!
        data = resource_klass.includes(serialized_relationships).all
        Success(
          data: data,
          status: SUCCESS_STATUS
        )
      end
    end
  end
end

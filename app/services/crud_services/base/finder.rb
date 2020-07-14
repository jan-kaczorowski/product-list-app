# frozen_string_literal: true

require 'dry/transaction/operation'

module CrudServices
  module Base
    class Finder < BaseCrudService
      SUCCESS_STATUS = 200

      def initialize(resource_klass:, id:)
        @resource_klass = resource_klass
        @id = id
      end

      attr_reader :id, :resource_klass

      def process!
        Success(
          data: resource,
          status: SUCCESS_STATUS
        )
      end

      private

      def resource
        resource_klass.find(id)
      end
    end
  end
end

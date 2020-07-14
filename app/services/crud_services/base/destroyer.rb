# frozen_string_literal: true

require 'dry/transaction/operation'

module CrudServices
  module Base
    class Destroyer < BaseCrudService
      SUCCESS_STATUS = 204

      def initialize(resource_klass:, id:)
        @resource_klass = resource_klass
        @id = id
      end

      attr_reader :resource_klass, :id

      def process!
        resource.destroy!
        Success(
          data: {},
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

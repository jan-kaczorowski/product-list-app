# frozen_string_literal: true

require 'dry/transaction/operation'

module CrudServices
  module Base
    class Updater < BaseCrudService
      SUCCESS_STATUS = 200
      MUST_BE_TRANSACTIONAL = true

      def initialize(resource_klass:, params:)
        @resource_klass = resource_klass
        @id = params.delete(:id)
        @attributes = params.delete(:attributes)
      end

      attr_reader :params, :id, :attributes, :resource_klass

      def process!
        resource.update!(attributes)
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

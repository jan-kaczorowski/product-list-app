# frozen_string_literal: true

require 'dry/transaction/operation'

module CrudServices
  module Base
    class Creator < BaseCrudService
      SUCCESS_STATUS = 201
      MUST_BE_TRANSACTIONAL = true
      def initialize(resource_klass:, params:)
        @resource_klass = resource_klass
        @params = params
      end

      attr_reader :resource_klass, :params

      def process!
        resource = resource_klass.create!(params)

        Success(
          data: resource,
          status: SUCCESS_STATUS
        )
      end
    end
  end
end

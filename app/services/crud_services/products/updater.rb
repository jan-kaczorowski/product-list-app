require "dry/transaction/operation"

module CrudServices
  module Products
    class Updater < CrudServices::Base::Updater
      include Dry::Transaction::Operation

      SUCCESS_STATUS = 200

      def initialize(resource_klass:, params:)
        @resource_klass = resource_klass
        @id = params.delete(:id)
        @attributes = params.delete(:attributes).to_h
      end

      def call
        ActiveRecord::Base.transaction do
          process_tag_attributes!

          resource.update!(attributes)
          Success(
            data: resource,
            status: SUCCESS_STATUS
          )
        end
      rescue StandardError => e
        Failure(
          error: e
        )
      end

      private

      attr_reader :id
      attr_accessor :attributes

      def resource
        resource_klass.find(id)
      end

      def process_tag_attributes!
        return unless attributes.fetch(:tags, []).any?

        tag_ids = attributes.delete(:tags).map do |tag_title|
          tag = Tag.find_or_create_by!(title: tag_title.strip)
          tag.id
        end

        attributes[:tag_ids] = tag_ids
      end
    end
  end
end

# frozen_string_literal: true

module Api
  module V1
    class TagsController < ApplicationController
      include CrudHelpers

      crud_service resource_klass: Tag,
                   serializer: TagSerializer

      def index
        render_collection fetcher.call
      end

      def show
        render_resource finder.call
      end

      def create
        render_resource creator.call
      end

      def update
        render_resource updater.call
      end

      def destroy
        render_deleted_resource destroyer.call
      end

      private

      def create_params
        params.require(:data)
              .require(:attributes)
              .permit(%i[title])
      end

      def update_params
        params.require(:data)
              .permit(:type, attributes: %i[title])
              .merge(params.permit(:id))
      end
    end
  end
end

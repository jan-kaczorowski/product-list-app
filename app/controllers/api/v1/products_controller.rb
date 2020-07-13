module Api
  module V1
    class ProductsController < ApplicationController
      include CrudHelpers
      
      CRUD_MODULE = CrudServices::Products
      
      def index
        render_collection fetcher.call
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

      def resource_serializer
        ProductSerializer
      end

      def create_params
        params.require(:data)
              .require(:attributes)
              .permit(%i[name description price])
      end

      def update_params
        params.require(:data)
              .permit(:type, :id, attributes: %i[name description price])
      end
    end
  end
end
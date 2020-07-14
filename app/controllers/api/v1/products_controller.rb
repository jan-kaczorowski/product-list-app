module Api
  module V1
    class ProductsController < ApplicationController
      include CrudHelpers

      crud_service resource_klass: Product,
                   serializer: ProductSerializer,
                   serialized_relationships: %i[tags taggings]

      def index
        render_collection fetcher.call
      end

      def show
        render_resource finder.call
      end

      def add_tag
        render_resource tagger_service.call
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

      def updater
        CrudServices::Products::Updater.new(
          resource_klass: self.class.resource_klass,
          params: update_params
        )
      end

      def create_params
        params.require(:data)
              .require(:attributes)
              .permit(%i[name description price])
      end

      def update_params
        params.require(:data)
              .permit(:type, attributes: [:name, :description, :price, tags: []])
              .merge(params.permit(:id))
      end

      def tagger_service
        CrudServices::Products::Tagger.new(
          id: params[:id],
          tag_name: params[:data][:attributes][:name]
        )
      end
    end
  end
end

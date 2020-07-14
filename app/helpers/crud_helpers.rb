# frozen_string_literal: true

module CrudHelpers
  module ClassMethods
    def crud_service(crud_module: CrudServices::Base,
                     resource_klass:,
                     serializer:,
                     serialized_relationships: [])
      @crud_module = crud_module
      @resource_klass = resource_klass
      @serializer = serializer
      @serialized_relationships = serialized_relationships
    end

    attr_reader :crud_module, :resource_klass, :serializer, :serialized_relationships
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  private

  def fetcher
    self.class.crud_module::Fetcher.new(
      resource_klass: self.class.resource_klass,
      serialized_relationships: self.class.serialized_relationships
    )
  end

  def finder
    self.class.crud_module::Finder.new(
      resource_klass: self.class.resource_klass,
      id: params[:id]
    )
  end

  def creator
    self.class.crud_module::Creator.new(
      resource_klass: self.class.resource_klass,
      params: create_params
    )
  end

  def updater
    self.class.crud_module::Updater.new(
      resource_klass: self.class.resource_klass,
      params: update_params
    )
  end

  def destroyer
    self.class.crud_module::Destroyer.new(
      resource_klass: self.class.resource_klass,
      id: params[:id]
    )
  end

  def render_resource(result)
    render json: result.value![:data],
           serializer: self.class.serializer,
           status: result.value![:status]
  end

  def render_deleted_resource(result)
    render nothing: true, status: result.value![:status]
  end

  def render_collection(result)
    render json: result.value![:data],
           each_serializer: self.class.serializer,
           include: self.class.serialized_relationships,
           status: result.value![:status]
  end
end

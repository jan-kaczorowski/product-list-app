
module CrudHelpers
  include Dry::Monads

  private

  def fetcher
    crud_module::Fetcher.new
  end

  def creator
    self::CRUD_MODULE::Creator.new(create_params)
  end

  def updater
    crud_module::Updater.new(update_params)
  end

  def destroyer
    crud_module::Destroyer.new(params[:id])
  end

  def render_resource(result, serializer: resource_serializer)
    handle_errors(result)
    render json: result.value![:data],
           serializer: serializer,
           status: result.value![:status]
  end

  def render_deleted_resource(result)
    handle_errors(result)

    render nothing: true, status: result.value![:status]
  end

  def render_collection(result, serializer: resource_serializer)
    handle_errors(result)
    render json: result.value![:data],
           each_serializer: serializer,
           status: result.value![:status]
  end

  def handle_errors(result)
    return unless result.is_a? Failure

    render json: {error: result.value![:error].to_s}
  end

  def crud_module
    self.class::CRUD_MODULE
  end

end
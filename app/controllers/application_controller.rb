class ApplicationController < ActionController::API
  rescue_from StandardError, with: :render_unexpected_error_response
  rescue_from ActionController::ParameterMissing,
              Errors::ExpectedError,
              with: :render_expected_error_response
  rescue_from Errors::ExpectedError, with: :render_expected_error_response

  def render_expected_error_response(exc)
    exc = Errors::ExpectedError.new(exc) unless exc.is_a? Errors::ExpectedError
    render json: exc.message_as_json, status: exc.status
  end

  def render_unexpected_error_response(exception)
    render json: { error: exception.message }, status: 500
  end
end

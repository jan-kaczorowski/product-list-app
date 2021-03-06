# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from StandardError, with: :render_unexpected_error_response
  rescue_from Errors::JsonSchemaError, with: :render_json_schema_error_response
  rescue_from ActionController::ParameterMissing,
              Errors::ExpectedError,
              with: :render_expected_error_response
  rescue_from Errors::ExpectedError, with: :render_expected_error_response

  def render_expected_error_response(exc)
    exc = Errors::ExpectedError.new(exc) unless exc.is_a? Errors::ExpectedError
    render json: exc.json_message, status: exc.status
  end

  def render_json_schema_error_response(exc)
    render json: exc.json_message, status: :unprocessable_entity
  end

  def render_unexpected_error_response(exc)
    render json: { error: exc.message }, status: 500
  end
end

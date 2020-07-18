module Errors
  class JsonSchemaError < StandardError
    def initialize(issues, mode)
      @issues = issues
      @mode = mode
      super(issues.to_s)
    end

    attr_reader :issues, :mode

    def json_message
      {
        data: {
          error: 'JSON_SCHEMA_VALIDATION_ERROR',
          mode: mode.to_s,
          message: issues,
          status: 422
        }
      }
    end
  end
end
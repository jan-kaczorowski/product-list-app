# frozen_string_literal: true

# TODO: DOC

require 'singleton'

module JsonSchemaValidatorHelper
  REQUEST_VALIDATION_METHODS_OMITTABLE = %w[GET HEAD OPTIONS DELETE].freeze
  RESPONSE_VALIDATION_METHODS_OMITTABLE = %w[HEAD OPTIONS DELETE].freeze
  DEFAULT_SCHEMA_FOLDER = 'schemas'

  module ClassMethods

    def validate_against_schema(error_klass:)
      @schema_error_klass = error_klass
    end

    def omit_request_validation(*actions)
      @req_validation_omittable_actions = actions
    end

    def omit_response_validation(*actions)
      @res_validation_omittable_actions = actions
    end

    attr_reader :schema_error_klass,
                :req_validation_omittable_actions,
                :res_validation_omittable_actions
  end

  class << self
    attr_writer :schema_folder

    def schema_folder
      @schema_folder || DEFAULT_SCHEMA_FOLDER
    end
  end

  class JsonSchemaProcessor
    include Singleton

    SCHEMA_FOLDER = 'schemas'
    FRAGMENTS = %w[definitions requests responses].freeze

    def schema
      @schema ||= proc do
        schema = {}
        root_schema_path = Rails.root.join('app', JsonSchemaValidatorHelper.schema_folder)
        namespaces = Dir[root_schema_path.join('*')]
                     .select { |file| File.directory? file }
                     .map { |file| File.basename file }
        # raise StandardError, "Json Schema folder invalid or empty" if namespaces.empty? and return
        namespaces.each do |namespace|
          schema[namespace] ||= {}
          FRAGMENTS.each do |fragment|
            # raise error if does not exist such fragment as folder
            schema[namespace][fragment] ||= {}
            Dir[root_schema_path.join(namespace, fragment, '*.json')].each do |file|
              req_name = File.basename(file, '.json').to_sym
              schema[namespace][fragment] ||= {}
              schema[namespace][fragment][req_name] = JSON.parse(File.read(file))
            end
          end
        end
        schema.deep_symbolize_keys
      end.call
    end
  end

  def self.included(base)
    base.extend ClassMethods

    base.class_eval do
      @req_validation_omittable_actions = []
      @res_validation_omittable_actions = []

      before_action :validate_request!

      after_action :validate_response!
    end
  end

  def validate_request!
    return if REQUEST_VALIDATION_METHODS_OMITTABLE.include? request.method
    return if omit_req_validation?
    return if request_errors.empty?

    raise self.class.schema_error_klass.new(request_errors, :request)
  end

  def validate_response!
    return if RESPONSE_VALIDATION_METHODS_OMITTABLE.include? request.method
    return if omit_res_validation?
    return if response_errors.empty?

    raise self.class.schema_error_klass.new(response_errors, :response)
  end

  def omit_req_validation?
    self.class.req_validation_omittable_actions.yield_self do |o_actions|
      o_actions == "ALL" || o_actions.include?(request_info[:action])
    end
  end

  def omit_res_validation?
    self.class.res_validation_omittable_actions.yield_self do |o_actions|
      o_actions == "ALL" || o_actions.include?(request_info[:action])
    end
  end

  def json_schema
    JsonSchemaProcessor.instance.schema
  end

  def request_info
    @request_info = Rails.application.routes.recognize_path(
      request.url,
      method: request.method
    ).yield_self do |req_info|
      {
        namespace: req_info.fetch(:controller).split('/')[0..-2].join('_'),
        controller: req_info.fetch(:controller).split('/')[-1],
        action: req_info.fetch(:action)
      }
    end
  end

  def check_validation_errors(payload, subset)
    JSON::Validator.fully_validate(
      json_schema.fetch(request_info[:namespace].to_sym),
      payload,
      fragment: fragment_selector(subset)
    )
  end

  def fragment_selector(subset)
    "#/#{subset}/#{request_info[:controller]}_#{request_info[:action]}"
  end

  def response_errors
    @response_errors ||= check_validation_errors(response.body, :responses)
  end

  def request_errors
    @request_errors ||= check_validation_errors(request.body.read, :requests)
  end
end

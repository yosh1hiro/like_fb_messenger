module Public
  module V1
    class Base < Grape::API
      version 'v1', using: :path
      format :json
      default_format :json
      formatter :json, Grape::Formatter::Rabl

      rescue_from ActiveRecord::RecordNotFound do |e|
        rack_response({ error: e.message }.to_json, 404)
      end

      rescue_from ActionController::BadRequest do |e|
        rack_response({ error: e.message }.to_json,  400)
      end

      rescue_from Grape::Exceptions::ValidationErrors do |e|
        rack_response e.to_json, 400
      end

      rescue_from :all do |e|
        Rails.logger.fatal(e)

        if Rails.env.production?
          error_response(message: "Internal server error", status: 500)
        else
          error_response(message: e.message, status: 500)
        end
      end

      mount Public::V1::Members
      mount Public::V1::Posts
      mount Public::V1::Rooms
      mount Public::V1::Users

      add_swagger_documentation(
        api_version: 'v1',
        format: 'json',
        mount_path: '/docs'
      ) unless Rails.env.production?
    end
  end
end

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
        error_response(message: 'Internal server error', status: 500)
      end

      mount Public::V1::Users

      mount Public::V1::Chats::Rooms
      mount Public::V1::Chats::Members
    end
  end
end

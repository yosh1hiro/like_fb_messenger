module Public
  module V1
    module Concerns
      module ErrorHandler
        extend ActiveSupport::Concern
        included do
          rescue_from ActiveRecord::RecordNotFound do |e|
            rack_response({ error: e.message}.to_json, 404)
          end

          rescue_from ActionController::BadRequest do |e|
            rack_response({ error: e.message }.to_json,  400)
          end

          rescue_from Grape::Exceptions::ValidationErrors do |e|
            rack_response e.to_json, 400
          end

          rescue_from ActiveRecord::RecordInvalid do |e|
            rack_response({ error: e.message }.to_json,  400)
          end

          rescue_from :all do |e|
            Rails.logger.fatal(e)

            if Rails.env.production?
              error_response(message: "Internal server error", status: 500)
            else
              error_response(message: e.message, status: 500)
            end
          end
        end
      end
    end
  end
end

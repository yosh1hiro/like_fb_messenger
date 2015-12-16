module Public
  module V1
    module Concerns
      module Session
        extend ActiveSupport::Concern
        included do
          helpers do
            def access_token
              return @access_token if @access_token.present?
              @access_token = request.env['HTTP_AUTHORIZATION'].try(:gsub, /^Bearer /, '').presence || params[:access_token]
            end

            def current_user
              @current_user ||= FiChat::Member::User.me(access_token)
            end

            def authenticate_user!
              fail ActionController::BadRequest if current_user.nil?
            end

            def current_admin
              @current_admin ||= FiChat::Member::Admin.me(access_token)
            end

            def authenticate_admin!
              fail ActionController::BadRequest if current_admin.nil?
            end
          end
        end
      end
    end
  end
end

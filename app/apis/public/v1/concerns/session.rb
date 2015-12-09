module Public
  module V1
    module Concerns
      module Session
        extend ActiveSupport::Concern
        included do
          helpers do
            def access_token
              @access_token ||= request.env['HTTP_AUTHORIZATION'].try(:match, /Bearer\s(.+)/).try(:[], 1)
              @access_token ||= params[:access_token]
            end

            def current_user
              @current_user ||= FiChat::Member::User.me(access_token)
            end

            def authenticate_user!
              fail ActionController::BadRequest if current_user.nil?
            end
          end
        end
      end
    end
  end
end

module Public
  module V1
    module Chats
      class Rooms < Grape::API
        params do
          requires :access_token, type: String
        end

        resources :chat do
          helpers do
            def user_api
              @user_api = Users::User.new
            end

            def me
              @me ||= user.me(access_token: params[:access_token])
            end
          end

          before do
            fail ActionController::BadRequest if me.nil?
          end
          resources :users do
            desc 'Get users list to start chat'
            params do
              requires :page, type: Integer, default: 1
            end
            get 'candidates', rabl: 'v1/chats/users/candidates' do
              @candidates = user_api.candidates(params[:access_token], params[:page])
              @page = params[:page].to_i
              @next_page = params[:page].to_i + 1
              @end_flag = (@candidate_users.count != 20)
            end
            params do
              requires :user_id, type: Integer
            end
            route_param :user_id do

              resources :rooms do

              end
            end
          end
        end
      end
    end
  end
end

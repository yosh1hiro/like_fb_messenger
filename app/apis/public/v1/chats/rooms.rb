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
              @user ||= User.new
            end

            def me
              @me ||= user_api.me(access_token: params[:access_token])
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
            get 'candidates', rabl: 'public/v1/chats/users/candidates' do
              @candidates_users = user_api.candidates(params[:access_token], params[:page])
              @page = params[:page].to_i
              @next_page = params[:page].to_i + 1
              @end_flag = user_api.cendidates_end_flag
            end

            # resources :rooms do
            #   desc 'Get all chat_room list'
            #   get '/', rabl: 'v3/chats/rooms/index' do
            #   end
            #   params do
            #     requires :chat_room_id, type: Integer
            #   end
            #   route_param :chat_room_id do
            #     helpers do
            #       def chat_room
            #       end
            #     end

            #     before do
            #       fail ActionController::BadRequest if chat_room.nil?
            #     end

            #     desc 'Show a chatroom'
            #     params do
            #       optional :page, type: Integer, default: 1
            #       optional :count, type: Integer, default: 20
            #     end
            #     get '/', rabl: 'v1/chats/rooms/show' do
            #       @page = params[:page]
            #     end

            #     desc 'Create a new message'
            #     params do
            #       requires :id, type: Integer
            #       requires :content_type, type: String
            #       optional :stamp_id, type: Integer
            #       optional :message, type: String
            #       optional :image
            #       requires :posted_at, type: String
            #     end
            #     post '/message', rabl: 'v3/chats/rooms/messages/show' do
            #     end

            #     desc 'Show recently posts after parameter date'
            #     params do
            #       requires :id, type: Integer
            #       requires :posted_after, type: String, default: Time.now
            #     end
            #     get ':id/latest_posts', rabl: 'v3/chats/rooms/latest_posts' do
            #     end
            #   end
            # end
          end
        end
      end
    end
  end
end

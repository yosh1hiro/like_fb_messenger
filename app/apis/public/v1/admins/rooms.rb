module Public
  module V1
    class Admins::Rooms < Grape::API
      namespace :admins do
        params do
          requires :access_token, type: String
        end

        before do
          authenticate_admin!
        end

        route_param :admin_id do
          desc 'Get direct chat_room list of admin'
          params do
            requires :admin_id, type: Integer
          end
          get '/rooms', rabl: 'public/v1/admins/rooms/index' do
            admin = FiChat::Member::Admin.find(params[:admin_id], access_token)
            fail ActionController::BadRequest if admin.blank?
            @chat_rooms = admin.chat_room_with_admin_index_caches
          end
        end

        resources :rooms do
          desc 'Get direct chat_room list of admin'
          get '/mine', rabl: 'public/v1/admins/rooms/index' do
            @chat_rooms = current_admin.chat_room_with_admin_index_caches
          end

          desc 'Start direct chat'
          params do
            requires :user_id, type: Integer
          end
          post '/', rabl: 'public/v1/admins/rooms/create' do
            user = FiChat::Member::User.find_list([params[:user_id]]).first
            fail ActionController::BadRequest if user.blank?
            @chat_room = ChatDirectWithAdminRoom.find_or_create_by(user, current_admin)
          end
        end
      end
    end
  end
end

module Public
  module V1
    class Admins::Rooms < Grape::API
      params do
        requires :access_token, type: String
      end
      namespace :admins do
        resources :rooms do
          get '' do
            case
            when "Admin"
              # @未実装 => adminの情報をgetするinternal apiの実装とapi clientの実装の必要
              @chat_room = ChatDirectWithAdminRoom.find_or_create_by(user_id: me.id, admin_id: 1).chat_room_index_cache
            end
          end

          desc 'Start direct chat'
          params do
            requires :user_id, type: Integer
          end
          post '/', rabl: 'public/v1/admins/rooms/create' do
            user = FiChat::Member::User.find_list([params[:user_id]]).first
            admin = FiChat::Member::Admin.me(params[:access_token])
            fail ActionController::BadRequest if user.blank? || admin.blank?

            @chat_room = ChatDirectWithAdminRoom.find_or_create_by(user, admin)
          end
        end
      end
    end
  end
end

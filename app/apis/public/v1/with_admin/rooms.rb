module Public
  module V1
    module WithAdmin
      class Rooms < Grape::API
        namespace :with_admin do
          before do
            fail ActionController::BadRequest if current_user.nil?
          end

          helpers do
            def target_admin
              @target_admin ||= FiChat::Member::Admin.find(params[:admin_id])
            end
          end

          params do
            optional :access_token, type: String
          end
          resources :rooms do
            params do
              optional :page, type: Integer, default: 1
              optional :count, type: Integer, default: 20
            end
            desc 'Get all chat_room list'
            get '/', rabl: 'public/v1/rooms/index' do
              @page = params[:page].to_i
              @next_page = @page + 1
              s = ::WithAdmin::ChatDirectRoomService.new(current_user, @page, params[:count])
              @chat_rooms = s.chat_direct_rooms
              @end_flag = (@chat_rooms.count != params[:count])
            end

            desc 'Start direct chat'
            params do
              requires :admin_id, type: Integer
            end
            post '/', rabl: 'public/v1/rooms/create' do
              admin = FiChat::Member::Admin.new({ 'id' => 1, 'last_name' => 'sample', 'first_name' => 'admin' }) # TODO: implement
              chat_room = ChatDirectWithAdminRoom.find_or_create_by(current_user, admin)
              s = ::WithAdmin::ChatDirectRoomPostService.new(current_user, chat_room.id, params[:page], params[:count])
              @chat_room = s.chat_direct_room
              @chat_posts = s.chat_posts
              @members = s.members
            end
          end
        end
      end
    end
  end
end

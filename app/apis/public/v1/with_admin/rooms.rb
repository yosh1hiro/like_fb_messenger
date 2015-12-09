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
          end
        end
      end
    end
  end
end

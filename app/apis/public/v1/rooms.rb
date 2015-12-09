module Public
  module V1
    class Rooms < Grape::API

      helpers do
        def other
          @other ||= FiChat::Member::User.find(params[:user_id], access_token)
        end
      end

      before do
        fail ActionController::BadRequest if current_user.nil?
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
          s = ChatDirectRoomService.new(current_user, @page, params[:count])
          @chat_rooms = s.chat_direct_rooms
          @end_flag = (@chat_rooms.count != params[:count])
        end

        desc 'Start direct chat'
        params do
          requires :user_id, type: Integer
        end
        post '/', rabl: 'public/v1/rooms/create' do
          fail ActionController::BadRequest if current_user.id == other.id
          # すぐにこの相互followかのjudgeはChatDirectRoomの責務として移譲したい。create時のvalidation
          fail ActionController::BadRequestif unless current_user.mutually_follow?(other)

          chat_room = ChatDirectRoom.find_or_create_by(current_user, other)
          s = ChatDirectRoomPostService.new(current_user, chat_room.id, params[:page], params[:count])
          @chat_room = s.chat_direct_room
          @chat_posts = s.chat_posts
          @members = s.members
        end

        params do
          requires :chat_room_id, type: Integer
        end
        route_param :chat_room_id do
          helpers do
            def chat_rooms
              @chat_rooms ||= current_user.chat_room_index_caches
            end

            def chat_room
              @chat_room ||= chat_rooms.find_by(chat_room_id: params[:chat_room_id])
            end
          end

          desc 'Show a chatroom'
          params do
            optional :page, type: Integer, default: 1
            optional :count, type: Integer, default: 20
          end
          get '/', rabl: 'public/v1/rooms/show' do
            @page = params[:page]
            @next_page = @page + 1
            s = ChatDirectRoomPostService.new(current_user, params[:chat_room_id], params[:page], params[:count])
            @chat_room = s.chat_direct_room
            @chat_posts = s.chat_posts
            @members = s.members
            @end_flag = @chat_posts.blank?
          end

          desc 'Show recently posts after parameter date'
          params do
            requires :chat_room_id, type: Integer
            requires :posted_after, type: Time, default: Time.now
          end
          get '/latest_posts', rabl: 'public/v1/rooms/latest_posts' do
            s = ChatDirectRoomPostedAfterService.new(current_user, params[:chat_room_id], params[:posted_after])
            @chat_room = s.chat_direct_room
            @chat_posts = s.chat_posts
            @members = s.members
          end
        end
      end
    end
  end
end

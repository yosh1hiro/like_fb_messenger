module Public
  module V1
    class Rooms < Grape::API

      helpers do
        def me
          @me ||= User::Me.new(params[:access_token])
        end

        def other
          @other ||= User::Me.new(params[:access_token]).other_user(params[:user_id])
        end
      end

      before do
        fail ActionController::BadRequest if me.nil?
      end

      params do
        requires :access_token, type: String
      end
      resources :rooms do
        desc 'Get all chat_room list'
        get '/', rabl: 'public/v1/rooms/index' do
          @chat_rooms = me.chat_room_index_caches
        end

        desc 'Start direct chat'
        params do
          requires :user_id, type: Integer
        end
        post '/', rabl: 'public/v1/rooms/create' do
          fail ActionController::BadRequest if me.id == other.id
          # すぐにこの相互followかのjudgeはChatDirectRoomの責務として移譲したい。create時のvalidation
          fail ActionController::BadRequestif unless me.mutually_follow?(other.id)

          @chat_room = ChatDirectRoom.find_or_create_by(me, other)#.chat_room_index_cache
        end

        params do
          requires :chat_room_id, type: Integer
        end
        route_param :chat_room_id do
          helpers do
            def chat_rooms
              @chat_rooms ||= me.chat_room_index_caches
            end

            def chat_room
              @chat_room ||= chat_rooms.find(params[:chat_room_id])
            end
          end

          desc 'Show a chatroom'
          params do
            optional :page, type: Integer, default: 1
            optional :count, type: Integer, default: 20
          end
          get '/', rabl: 'public/v1/rooms/show' do
            @chat_room = chat_room
            @page = params[:page]
          end

          desc 'Show recently posts after parameter date'
          params do
            requires :chat_room_id, type: Integer
            requires :posted_after, type: Time, default: Time.now
          end
          get '/latest_posts', rabl: 'public/v1/rooms/latest_posts' do
            @chat_posts = ChatPostCache.where('posted_at > ?', params[:posted_after])
          end
        end
      end
    end
  end
end

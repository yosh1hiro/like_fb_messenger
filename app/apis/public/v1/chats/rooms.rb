module Public
  module V1
    module Chats
      class Rooms < Grape::API

        params do
          requires :access_token, type: String
        end

        resources :chat do
          helpers do
            def me
              @me ||= User::Me.new.me(access_token: params[:access_token])
            end
          end

          before do
            fail ActionController::BadRequest if me.nil?
          end

          # client sideとのchat_room_idの受け取りと受け渡しは全て、chat_room_index_cacheのidに統一する
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

            resources :rooms do
              desc 'Get all chat_room list'
              get '/', rabl: 'public/v1/chats/rooms/index' do
                @chat_rooms = me.chat_room_index_caches
              end

              desc 'start direct chat'
              params do
                requires :target_id, type: Integer
                requires :target_type, :type: String
              end
              post '/', rabl: 'public/v1/chats/rooms/show' do
                case params[:target_type]
                when "User"
                  @user = User::Other.new.other(params[:access_token], params[:user_id])
                  fail ActionController::BadRequest if me.id == @user.id
                  if me.mutually_follow?(params[:access_token], params[:user_id])  # すぐにこの相互followかのjudgeはChatDirectRoomの責務として移譲したい。create時のvalidation
                    @chat_room = ChatDirectRoom.find_or_create_by(me, @user).chat_room_index_cache
                  else
                    fail ActionController::BadRequest
                  end
                when "Admin"
                  # @未実装 => adminの情報をgetするinternal apiの実装とapi clientの実装の必要
                  @chat_room = ChatDirectWithAdminRoom.find_or_create_by(user_id: me.id, admin_id: 1).chat_room_index_cache
                else
                  fail ActionController::BadRequest
                end
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

                  def chat_post_params
                    ActionController::Parameters.new(params) \
                        .permit(:stamp_id, :message, :image, :posted_at).merge(sender_id: me.id)
                  end
                end

                before do
                  fail ActionController::BadRequest if chat_room.nil?
                end

                desc 'Show a chatroom'
                params do
                  optional :page, type: Integer, default: 1
                  optional :count, type: Integer, default: 20
                end
                get '/', rabl: 'public/v1/chats/rooms/show' do
                  @chat_room = chat_room
                  @page = params[:page]
                end

                desc 'Create a new message'
                params do
                  requires :content_type, type: String
                  optional :stamp_id, type: Integer
                  optional :message, type: String
                  optional :image
                  requires :posted_at, type: String
                end
                post '/message', rabl: 'public/v1/chats/rooms/message' do
                  room = chat_room.chat_room
                  case params[:content_type]
                  when 'message'
                    fail ActionController::BadRequest if params[:message].blank?
                    @chat_post = room.chat_direct_messages.new(chat_post_params)
                  when 'stamp'
                    fail ActionController::BadRequest if params[:stamp_id].blank?
                    @chat_post = room.chat_direct_stamps.new(chat_post_params)
                  when 'image'
                    fail ActionController::BadRequest if params[:image].blank?
                    @chat_post = room.chat_direct_images.new(chat_post_params)
                  else
                    fail ActionController::BadRequest
                  end
                  @chat_post.save!
                end

                desc 'Show recently posts after parameter date'
                params do
                  requires :id, type: Integer
                  requires :posted_after, type: String, default: Time.now
                end
                get ':id/latest_posts', rabl: 'public/v1/chats/rooms/latest_posts' do
                  @chat_room = chat_room
                  @chat_posts = @chat_room.chat_post_caches.where(ChatPostCache.arel_table[:posted_at].gteq params[:posted_after]).order(posted_at: :asc)
                end
              end
            end
          end
        end
      end
    end
  end
end

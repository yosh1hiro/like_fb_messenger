module Public
  module V1
    class Admins::Posts < Grape::API
      namespace :admins do
        resources :posts do
          params do
            requires :access_token, type: String
          end

          before do
            authenticate_admin!
          end

          helpers do
            def chat_room
              @chat_room ||= ChatDirectWithAdminRoom.find(params[:room_id])
            end

            def chat_post_params
              ActionController::Parameters.new(params) \
                .permit(:stamp_id, :message)
            end

            def create_chat_post_cache!(chat_post)
              chat_post.sender = current_admin
              chat_post.save_with_cache!
              chat_post.chat_post_cache
            end
          end

          desc 'Create a new message'
          params do
            requires :content_type, type: String
            requires :room_id, type: Integer
            optional :stamp_id, type: Integer
            optional :message, type: String
            optional :image
          end
          post '/', rabl: 'public/v1/admins/posts/show' do
            case params[:content_type]
            when 'message'
              fail ActionController::BadRequest if params[:message].blank?
              chat_post = chat_room.chat_direct_with_admin_from_admin_messages.new(chat_post_params)
              @chat_post = create_chat_post_cache!(chat_post)
            when 'stamp'
              fail ActionController::BadRequest if params[:stamp_id].blank?
              chat_post = chat_room.chat_direct_with_admin_from_admin_stamps.new(chat_post_params)
              @chat_post = create_chat_post_cache!(chat_post)
            when 'image'
              fail ActionController::BadRequest if params[:image].blank?
            else
              fail ActionController::BadRequest
            end
          end
        end
      end
    end
  end
end

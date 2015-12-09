module Public
  module V1
    class Posts < Grape::API
      params do
        optional :access_token, type: String
      end

      before do
        authenticate_user!
      end

      helpers do
        def chat_room
          @chat_room ||= ChatDirectRoom.find(params[:room_id])
        end
      end

      resources :posts do
        helpers do
          def chat_post_params
            ActionController::Parameters.new(params) \
              .permit(:stamp_id, :message).merge(sender_id: current_user.id)
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
        post '/', rabl: 'public/v1/posts/show' do
          case params[:content_type]
          when 'message'
            fail ActionController::BadRequest if params[:message].blank?
            @chat_post = chat_room.chat_direct_messages.new(chat_post_params)
            @chat_post.sender = me
            @chat_post.save_with_cache!
          when 'stamp'
            fail ActionController::BadRequest if params[:stamp_id].blank?
            @chat_post = chat_room.chat_direct_stamps.new(chat_post_params)
            @chat_post.sender = me
            @chat_post.save_with_cache!
          when 'image'
            fail ActionController::BadRequest if params[:image].blank?
            @chat_post = chat_room.chat_direct_images.new(chat_post_params)
            @chat_post.image = params[:image]
            @chat_post.sender = me
            @chat_post.save_with_cache!
          else
            fail ActionController::BadRequest
          end
        end
      end
    end
  end
end

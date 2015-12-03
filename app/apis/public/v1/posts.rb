module Public
  module V1
    class Posts < Grape::API
      params do
        requires :access_token, type: String
      end

      helpers do
        def me
          @me ||= User::Me.new(params[:access_token])
        end

        def chat_room
          @chat_room ||= ChatDirectRoom.find(params[:room_id])
        end
      end

      resources :posts do
        helpers do
          def chat_post_params
            ActionController::Parameters.new(params) \
              .permit(:stamp_id, :message).merge(sender_id: me.id)
          end
        end

        desc 'Create a new message'
        params do
          requires :content_type, type: String
          requires :room_id
          optional :stamp_id, type: Integer
          optional :message, type: String
          optional :image
        end
        post '/', rabl: 'public/v1/posts/show' do
          case params[:content_type]
          when 'message'
            fail ActionController::BadRequest if params[:message].blank?
            @chat_post = chat_room.chat_direct_messages.new(chat_post_params)
          when 'stamp'
            fail ActionController::BadRequest if params[:stamp_id].blank?
            @chat_post = chat_room.chat_direct_stamps.new(chat_post_params)
          when 'image'
            fail ActionController::BadRequest if params[:image].blank?
            @chat_post = chat_room.chat_direct_images.new(chat_post_params)
            @chat_post.image = image
          else
            fail ActionController::BadRequest
          end
          @chat_post.save!
        end
      end
    end
  end
end

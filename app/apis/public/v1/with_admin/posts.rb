module Public
  module V1
    module WithAdmin
      class Posts < Grape::API
        params do
          optional :access_token, type: String
        end

        helpers do
          def chat_room
            @chat_room ||= ChatDirectWithAdminRoom.find_by(id: params[:room_id], user_id: current_user.id)
          end
        end

        namespace :with_admin do
          resources :posts do
            helpers do
              def chat_post_params
                ActionController::Parameters.new(params) \
                  .permit(:stamp_id, :message)
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
            post '/', rabl: 'public/v1/with_admin/posts/show' do
              case params[:content_type]
              when 'message'
                fail ActionController::BadRequest if params[:message].blank?
                @chat_post = chat_room.chat_direct_with_admin_messages.new(chat_post_params)
                @chat_post.sender = current_user
                @chat_post.save_with_cache!
              when 'stamp'
                fail ActionController::BadRequest if params[:stamp_id].blank?
                @chat_post = chat_room.chat_direct_with_admin_stamps.new(chat_post_params)
                @chat_post.sender = current_user
                @chat_post.save_with_cache!
              when 'image'
                fail ActionController::BadRequest if params[:image].blank?
                @chat_post = chat_room.chat_direct_with_admin_images.new(chat_post_params)
                @chat_post.image = params[:image]
                @chat_post.sender = current_user
                @chat_post.save_with_cache!
              else
                fail ActionController::BadRequest
              end
            end
          end
        end
      end
    end
  end
end

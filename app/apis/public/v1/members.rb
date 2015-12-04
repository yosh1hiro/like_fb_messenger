module Public
  module V1
    class Members < Grape::API

      helpers do
        def me
          @me ||= FiChat::Member::User.me(params[:access_token])
        end
      end

      params do
        requires :access_token, type: String
        requires :room_id, type: Integer
      end
      resources :rooms do
        route_param :room_id do
          resources :members do
            get '/', rabl: 'public/v1/members/index.rabl' do
              chat_room = ChatDirectRoom.find(params[:room_id])
              target_user_ids = chat_room.chat_direct_room_members.where(my_user_id: me.id).pluck(:target_user_id)
              @members = FiChat::Members.new(FiChat::Member::User.find_list(target_user_ids)).members
            end
          end
        end
      end
    end
  end
end

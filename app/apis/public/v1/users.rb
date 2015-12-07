module Public
  module V1
    class Users < Grape::API

      params do
        requires :access_token, type: String
      end
      resource :users do
        # client sideとのchat_room_idの受け取りと受け渡しは全て、chat_room_index_cacheのidに統一する
        desc 'Get users list to start chat'
        params do
          requires :page, type: Integer, default: 1
          requires :access_token, type: String
        end
        get 'candidates', rabl: 'public/v1/users/candidates' do
          @page = params[:page]
          @next_page = @page + 1
          @users = FiChat::Member::User.candidates(@page, params[:access_token])
        end

        params do
          requires :q, type: String, default: ''
        end
        get 'search', rabl: 'public/v1/users/search' do
          if params[:q].blank?
            @users = []
          else
            @users = FiChat::Member::User.candidates(1, params[:access_token])
          end
        end
      end
    end
  end
end

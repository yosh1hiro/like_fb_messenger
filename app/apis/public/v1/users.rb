module Public
  module V1
    class Users < Grape::API

      helpers do
        def me
          @me ||= User::Me.new(params[:access_token]).me
        end
      end

      resource :users do
        # client sideとのchat_room_idの受け取りと受け渡しは全て、chat_room_index_cacheのidに統一する
        desc 'Get users list to start chat'
        params do
          requires :page, type: Integer, default: 1
        end
        get 'candidates', rabl: 'public/v1/users/candidates' do
          @page = params[:page]
          @next_page = @page + 1
          @candidates_users = me.candidates(@page)
          @end_flag = me.cendidates_end_flag
        end
      end
    end
  end
end

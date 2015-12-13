module Public
  module V1
    class Admins < Grape::API
      resource :admins do
        desc 'Get access_token of admin'
        params do
          requires :email, type: String
          requires :password, type: String
        end
        post 'sign_in', rabl: 'public/v1/admins/sign_in' do
          @access_token = RequlMobileAdminApi.access_token(params[:email], params[:password])
        end
      end
    end
  end
end

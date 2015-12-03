module Public
  module V1
    class Members < Grape::API
      params do
        requires :access_token, type: String
      end
      resources :rooms do
        params do
          requires :room_id, type: Integer
        end
        route_param :room_id do
          resources :members do
            get '/', 'members/index.rabl' do
            end
          end
        end
      end
    end
  end
end

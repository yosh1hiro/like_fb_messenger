module Public
  module V1
    class Members < Grape::API
      resources :chat do
        resources :rooms do
          params do
            requires :room_id, type: Integer
          end
          route_param :room_id do
            resources :members do
            end
          end
        end
      end
    end
  end
end

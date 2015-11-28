module Public
  module V1
    module Chats
      class Members < Grape::API
        resources :chat do
          params do
            requires :user_id, type: Integer
          end
          route_param :user_id do

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
  end
end

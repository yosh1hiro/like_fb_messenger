module Public
  module V1
    module Chats
      class Rooms < Grape::API
        resources :chat do
          params do
            requires :user_id, type: Integer
          end
          route_param :user_id do

            resources :rooms do

            end
          end
        end
      end
    end
  end
end

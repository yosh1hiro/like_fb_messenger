module Public
  module V1
    class Rooms < Grape::API
      resources :chat do
        resources :rooms do

        end
      end
    end
  end
end

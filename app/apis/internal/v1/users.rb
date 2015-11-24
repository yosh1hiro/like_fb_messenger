module Internal
  module V1
    class Users < Grape::API
      resource :users do
        get '/', rabl: 'internal/v1/users/index' do
          @time = Time.now
        end
      end
    end
  end
end

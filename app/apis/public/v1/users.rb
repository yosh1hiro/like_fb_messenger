module Public
  module V1
    class Users < Grape::API
      resource :users do
        get '/', rabl: 'public/v1/users/index' do
          @time = Time.now
        end
      end
    end
  end
end

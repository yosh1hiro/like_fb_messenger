class API < Grape::API
  mount Public::V1::Base
  mount Internal::V1::Base
end

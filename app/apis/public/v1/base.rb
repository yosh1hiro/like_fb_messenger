module Public
  module V1
    class Base < Grape::API
      version 'v1', using: :path
      format :json
      default_format :json
      formatter :json, Grape::Formatter::Rabl

      include Public::V1::Concerns::ErrorHandler
      include Public::V1::Concerns::Session

      mount Public::V1::Members
      mount Public::V1::Posts
      mount Public::V1::Rooms
      mount Public::V1::Users

      mount Public::V1::WithAdmin::Posts
      mount Public::V1::WithAdmin::Rooms

      add_swagger_documentation(
        api_version: 'v1',
        format: 'json',
        mount_path: '/docs'
      ) unless Rails.env.production?
    end
  end
end

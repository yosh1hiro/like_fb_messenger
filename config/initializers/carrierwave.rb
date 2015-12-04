unless Rails.env.test?
  CarrierWave.configure do |config|
    config.cache_dir = "#{Rails.root}/tmp/uploads"
    config.storage                          = :fog
    config.fog_credentials                  = {
      :provider              => 'AWS',
      :aws_access_key_id     => Settings.aws.access_key_id,
      :aws_secret_access_key => Settings.aws.secret_access_key,
      :region                => 'ap-northeast-1'
    }
    config.fog_directory                    = Settings.aws.fog_directory
    config.fog_public                       = false
    config.fog_authenticated_url_expiration = 24 * 60 * 60
  end
else
  CarrierWave.configure do |config|
    config.storage = :file
  end
end

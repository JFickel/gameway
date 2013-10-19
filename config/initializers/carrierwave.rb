CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['AWS_ID'],
    :aws_secret_access_key  => ENV['AWS_SECRET']
  }
  case Rails.env
    when "testing"
      config.fog_directory = 'gameway_development'
    when "development"
      config.fog_directory = 'gameway_development'
    when "staging"
      config.fog_directory = 'gameway_staging'
    when "production"
      config.fog_directory = 'gameway_production'
  end
end

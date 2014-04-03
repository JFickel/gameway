CarrierWave.configure do |config|
  config.storage = :fog
  config.root = Rails.root
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['AWS_ID'],
    :aws_secret_access_key  => ENV['AWS_SECRET']
  }
  case Rails.env
    when "testing"
      config.fog_directory = 'gameway-development'
    when "development"
      config.fog_directory = 'gameway-development'
    when "staging"
      config.fog_directory = 'gameway-staging'
    when "production"
      config.fog_directory = 'gameway-production'
  end
end

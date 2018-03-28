# frozen_string_literal: true

CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'

  config.fog_credentials = {
    provider: 'AWS', # required
    aws_access_key_id: ENV['S3_KEY'],
    aws_secret_access_key: ENV['S3_SECRET'],
    region: 'eu-central-1' # optional, defaults to 'us-east-1'
  }

  # Use local storage if in development or test
  config.storage = :file if Rails.env.development? || Rails.env.test?

  # Use AWS storage if in production
  config.storage = :fog if Rails.env.production?

  config.fog_directory  = ENV['aws_bucket'] # required
  # config.fog_host       = 'https://assets.example.com'           # optional, defaults to nil
  # config.fog_public     = false                                  # optional, defaults to true
  config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' } # optional, defaults to {}
end

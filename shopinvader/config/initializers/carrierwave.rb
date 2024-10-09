CarrierWave.configure do |config|

  config.cache_dir = File.join(Rails.root, 'tmp', 'uploads')

  case Rails.env.to_sym

  when :development
    config.storage = :file
    config.root = File.join(Rails.root, 'public')

  when :production
    begin
      # context: when we're precompiling the assets in the Dockerfile
      break if ENV['S3_BUCKET'].blank?

      # config.storage = :file
      # config.root = File.join(Rails.root, 'public')

      # Put your CDN host below instead
      if ENV['S3_ASSET_HOST_URL'].present?
        config.asset_host = ENV['S3_ASSET_HOST_URL']
      end

      # # You can also use Amazon S3 instead. The following configuration works for AWS
      # #
      # # WARNING: add the "carrierwave-aws" gem in your Rails app Gemfile.
      # # More information here: https://github.com/sorentwo/carrierwave-aws
      #
      config.storage          = :aws
      config.aws_bucket       = ENV['S3_BUCKET']
      config.aws_acl          = 'public-read'

      # Use a different endpoint (eg: another provider such as Exoscale)
      if ENV['S3_ENDPOINT'].present?
        config.aws_credentials[:endpoint] = ENV['S3_ENDPOINT']
      end

      # For some endpoint like minio you need to rewrite path 
      if ENV['S3_PATH_STYLE'].present?
        config.aws_credentials[:force_path_style] = ENV['S3_PATH_STYLE']
      end
    
      config.aws_attributes = {
        cache_control: ENV['S3_CACHE_CONTROL']
      }


      config.aws_credentials  = {
        access_key_id:      ENV['S3_KEY_ID'],
        secret_access_key:  ENV['S3_SECRET_KEY'],
        region:             ENV['S3_BUCKET_REGION']
      }


    end

  else
    # settings for the local filesystem
    config.storage = :file
    config.root = File.join(Rails.root, 'public')
  end

end

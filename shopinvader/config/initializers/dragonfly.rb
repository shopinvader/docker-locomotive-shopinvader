# Images are transformed by the Heroku app leading to bigger memory + cpu consumption
# This is why it's a good practice to use another Ruby app to handle the transformations
TRANSFORMED_IMAGES_SERVICE_URL = ENV['DRAGONFLYAPP_HOST'] || ENV['DRAGONFLYAPP_URL'] || Rails.application.config.action_controller.asset_host

# Configure
Dragonfly.app(:engine).configure do
  plugin :imagemagick,
    convert_command:  `which convert`.strip.presence || '/usr/local/bin/convert',
    identify_command: `which identify`.strip.presence || '/usr/local/bin/identify'

  processor :thumb, Locomotive::Dragonfly::Processors::SmartThumb.new

  if Rails.env.production?
    verify_urls true

    secret ENV['DRAGONFLY_SECRET_KEY']
  else
    verify_urls false
  end

  url_format '/images/dynamic/:job/:sha/:basename.:ext'

  fetch_file_whitelist /public/

  fetch_url_whitelist /.+/

  # we don't care if this is the Heroku app converting the image
  url_host (case Rails.env.to_sym
  when :production then TRANSFORMED_IMAGES_SERVICE_URL
  else nil; end)
end

Dragonfly.app(:steam).configure do
  url_host (case Rails.env.to_sym
  when :production then TRANSFORMED_IMAGES_SERVICE_URL
  else nil; end)
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware, :engine

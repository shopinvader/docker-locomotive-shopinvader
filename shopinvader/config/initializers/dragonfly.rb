# Configure
Dragonfly.app(:engine).configure do
  plugin :imagemagick,
    convert_command:  `which convert`.strip.presence || '/usr/local/bin/convert',
    identify_command: `which identify`.strip.presence || '/usr/local/bin/identify'

  processor :thumb, Locomotive::Dragonfly::Processors::SmartThumb.new

  verify_urls true

  secret ENV['DRAGON_FLY_SECRET']

  url_format '/images/dynamic/:job/:sha/:basename.:ext'

  fetch_file_whitelist /public/

  fetch_url_whitelist /.+/

  url_host (case Rails.env.to_sym
  when :production then Rails.application.config.action_controller.asset_host
  else nil; end)
end

Dragonfly.app(:steam).configure do
  url_host (case Rails.env.to_sym
  when :production  then Rails.application.config.action_controller.asset_host
  else nil; end)
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware, :engine

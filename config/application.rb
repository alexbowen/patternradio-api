require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Project
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.middleware.insert_before 0, Rack::Cors do
      allow do origins 'localhost:3000',
          '127.0.0.1:3000',
          /\Ahttp:\/\/192\.168\.0\.\d{1,3}(:\d+)?\z/
          # regular expressions can be used here
          resource '/file/list_all/',
              headers: 'x-domain-token'
          resource '/file/at/*',
              methods: [:get, :post, :delete, :put, :patch, :options, :head],
              headers: 'x-domain-token',
              expose: ['Some-Custom-Response-Header'],
              max_age: 600
          # headers to expose
      end
  
      allow do origins '*'
          resource '/public/*',
              headers: :any,
              methods: :get
          # Only allow a request for a specific host
          resource '/api/*/**',
              headers: :any,
              methods: :get
      end
    end

    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end
  end
end

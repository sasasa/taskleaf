require_relative 'boot'


require 'csv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Taskleaf
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.time_zone = 'Asia/Tokyo'

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.generators do |g|
      g.assets false
      g.helper false
      g.jbuilder false

      g.test_framework :rspec, 
            view_specs: false, 
            helper_specs: false, 
            controller_specs: false, 
            routing_specs: false
            # fixtures: false,
    end
  end
end

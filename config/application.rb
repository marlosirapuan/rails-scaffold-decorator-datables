require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Abc
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Timezone
    config.time_zone = 'America/Sao_Paulo'
    config.active_record.default_timezone = :local

    # I18ln
    config.i18n.load_path +=
      Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :'pt-BR'

    # Generators
    config.generators do |g|
      g.assets              false
      g.helper              false
      g.javascripts         false
      g.stylesheets         false
      g.scaffold_stylesheet false
      g.view_specs          false
    end

    # ActiveJob
    config.active_job.queue_adapter = :sidekiq
    config.active_job.queue_name_prefil = 'abc'
    config.active_job.queue_name_delimiter = '_'
  end
end

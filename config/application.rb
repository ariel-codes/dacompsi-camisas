require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cluby
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.eager_load_paths << Rails.root.join("extras")

    config.active_record.sqlite3_adapter_strict_strings_by_default = true

    config.active_job.queue_adapter = :delayed_job

    config.time_zone = "America/Sao_Paulo"
    config.i18n.available_locales = ["pt-BR"]
    config.i18n.default_locale = "pt-BR"
    config.beginning_of_week = :sunday

    routes.default_url_options = {host: ENV.fetch("URL_HOST", "localhost"), protocol: ENV.fetch("URL_PROTOCOL", "http")}
    config.action_mailer.default_url_options = routes.default_url_options
  end
end

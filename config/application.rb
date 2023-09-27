require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ShadcnRailsTemplate
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

    # Don't generate system test files.
    config.active_job.queue_adapter = :sidekiq
    config.active_job.queue_name_prefix = "an_optional_queue_prefix"
    
    config.generators.after_generate do |files|
      parsable_files = files.filter { |file| file.end_with?('.rb') }
      system("bundle exec rubocop -A --fail-level=E #{parsable_files.shelljoin}", exception: true)
    end
    config.generators.system_tests = nil

    config.active_record.encryption.primary_key = "x7uBduWzxpIGpEv6KJaIl6S3KbPq89aY"
    config.active_record.encryption.deterministic_key = "leSN9AW7nE0d6E0du0Qy8QToFqOMy4IS"
    config.active_record.encryption.key_derivation_salt = "GSpKicS4w0ZdGMdrI4ZeaxMrvT2gSHLX"
  end
end

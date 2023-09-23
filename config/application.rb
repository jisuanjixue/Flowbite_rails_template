require_relative 'boot'

require 'action_cable/engine'
require 'action_controller/railtie'
require 'action_mailbox/engine'
require 'action_mailer/railtie'
require 'action_text/engine'
require 'action_view/railtie'
require 'active_job/railtie'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'rails'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ShadcnRailsTemplate
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    Dir[Rails.root.join('lib/middleware/**/*.{rb}')].sort.each { |file| require file }

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.active_job.queue_adapter = :sidekiq
    config.active_job.queue_name_prefix = 'an_optional_queue_prefix'

    config.generators.after_generate do |files|
      parsable_files = files.filter { |file| file.end_with?('.rb') }
      system("bundle exec rubocop -A --fail-level=E #{parsable_files.shelljoin}", exception: true)
    end
    config.generators.system_tests = nil

    config.active_record.encryption.primary_key = 'Q3TJUKuOUGSZmgqaD2WZ72pQdg5Rikfn'
    config.active_record.encryption.deterministic_key = 'lYew1Q7BE98tDXdqytP3iwvJcu8dYulX'
    config.active_record.encryption.key_derivation_salt = '9REysw2kZuLybtKjtJsIZHg8cTd2DyMT'
  end
end

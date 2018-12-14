require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'rails/test_unit/railtie'
require_relative 'rails_env'

Bundler.require(*Rails.groups)

module BpAndelaMedia
  class Application < Rails::Application
    config.load_defaults 5.2
    config.api_only = true
    config.i18n.fallbacks = true

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: true,
        request_specs: true
      g.fixture_replacement :factory_bot, dir: "spec/factories"
      g.orm :active_record, primary_key_type: :uuid
    end
    # config.active_job.queue_adapter = :sidekiq
    ActiveModelSerializers.config.adapter = :json_api
  end
end

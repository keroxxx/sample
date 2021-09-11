require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Sample
  class Application < Rails::Application
    config.load_defaults 6.0
    config.generators do |g|
      g.test_framework :rspec,
                      helper_specs: false,
                      routing_specs: false,
                      view_specs: false,
                      controller_specs: false
    end
    # 認証トークンをremoteフォームに埋め込む
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end

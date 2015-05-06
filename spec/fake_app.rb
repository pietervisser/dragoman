class ApplicationController < ActionController::Base
  protect_from_forgery
end

module Dummy

  def self.rails4?
    Rails::VERSION::MAJOR >= 4
  end

  class Application < Rails::Application
    config.secret_key_base = "test"
    config.paths["public"] = ["spec/fixtures/public"]
    config.paths["config/locales"] = ["spec/fixtures/locales/routes.yml"]
    config.eager_load = false
    config.i18n.fallbacks = true

    if Dummy.rails4?
      config.paths["config/routes.rb"] = ["spec/fixtures/config/routes.rb"]
    else
      config.paths["config/routes"] = ["spec/fixtures/config/routes.rb"]
    end

  end
end

Dummy::Application.initialize!
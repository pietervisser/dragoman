class ApplicationController < ActionController::Base
  protect_from_forgery
end

module Dummy
  class Application < Rails::Application
    config.secret_key_base = "test"
    config.paths["public"] = ["spec/fixtures/public"]
    config.paths["config/routes.rb"] = ["spec/fixtures/config/routes.rb"]
    config.paths["config/locales"] = ["spec/fixtures/locales/routes.yml"]
    config.eager_load = false
  end
end

Dummy::Application.initialize!
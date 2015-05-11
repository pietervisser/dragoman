ENV["RAILS_ENV"] = "test"

# require 'rails/all'

require "action_controller/railtie"
require 'action_view/railtie'
require 'action_dispatch/railtie'
require 'rspec/rails'

require "dragoman"
require 'fake_app'

Rails.application.routes.default_url_options[:host] = 'example.com'

Rails.backtrace_cleaner.remove_silencers!

RSpec.configure do |config|

  config.infer_spec_type_from_file_location!

  config.after(:all) do
    print_routes
  end

  config.after(:each) do
    I18n.locale = I18n.default_locale = :en
  end

end
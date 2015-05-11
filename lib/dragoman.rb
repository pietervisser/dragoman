module Dragoman
  Journey = if Rails::VERSION::MAJOR >= 4
    ActionDispatch::Journey
  else
    require 'journey'
    Journey
  end
end

require "dragoman/translator"
require "dragoman/translation_visitor"
require "dragoman/url_helpers"
require "dragoman/mapper"
require "dragoman/railtie" if defined?(Rails)
require "dragoman/version"
require "dragoman/route_set"
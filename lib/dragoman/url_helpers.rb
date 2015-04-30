module Dragoman
  class UrlHelpers

    def self.add_untranslated_helpers name, route_set
      route_set.named_routes.path_helpers_module.send :define_method, "#{name}_path" do |*args|
        __send__(Dragoman::UrlHelpers.localized_helper_name(name, :path), *args)
      end
      route_set.named_routes.url_helpers_module.send :define_method, "#{name}_url" do |*args|
        __send__(Dragoman::UrlHelpers.localized_helper_name(name, :url), *args)
      end
    end

    def self.localized_helper_name name, url_helper_type
      locale = I18n.locale
      "#{name}_#{locale}_#{url_helper_type}"
    end

  end
end
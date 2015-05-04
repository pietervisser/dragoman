module Dragoman
  class UrlHelpers

    def self.add_untranslated_helpers name, path_module, url_module
      path_module.send :define_method, "#{name}_path" do |*args|
        __send__(Dragoman::UrlHelpers.localized_helper_name(name, :path), *args)
      end
      url_module.send :define_method, "#{name}_url" do |*args|
        __send__(Dragoman::UrlHelpers.localized_helper_name(name, :url), *args)
      end
    end

    def self.localized_helper_name name, url_helper_type
      locale = I18n.locale
      "#{name}_#{locale}_#{url_helper_type}"
    end

  end
end
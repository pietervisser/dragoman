module Dragoman
  class UrlHelpers

    def self.add_untranslated_helpers name, path_module, url_module
      path_module.send :define_method, "#{name}_path" do |*args|
        __send__(Dragoman::UrlHelpers.localized_helper_name(name, :path), *Dragoman::UrlHelpers.args_with_locale(*args))
      end
      url_module.send :define_method, "#{name}_url" do |*args|
        __send__(Dragoman::UrlHelpers.localized_helper_name(name, :url), *Dragoman::UrlHelpers.args_with_locale(*args))
      end
    end

    def self.localized_helper_name name, url_helper_type
      locale = I18n.locale
      "#{name}_#{locale}_#{url_helper_type}"
    end

    def self.args_with_locale *args
      if args[0].is_a?(Hash)
        args[0].merge!({locale: I18n.locale})
      else
        args << {locale: I18n.locale}
      end
      args
    end

  end
end
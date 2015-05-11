module Dragoman
  module RouteSetRails4

    def self.included(base)
      base.send :alias_method_chain, :add_route, :localization
    end

    def add_route_with_localization(app, conditions = {}, requirements = {}, defaults = {}, name = nil, anchor = true)
      dragoman_options = defaults.delete :dragoman_options
      if dragoman_options
        Dragoman::UrlHelpers.add_untranslated_helpers name, named_routes.path_helpers_module, named_routes.url_helpers_module if name
        dragoman_options[:locales].each do |locale|
          new_conditions = conditions.dup
          new_requirements = requirements.dup

          new_name = name ? "#{name}_#{locale}" : nil
          new_name = nil if new_name && named_routes.routes[new_name.to_sym]

          if new_path = new_conditions.delete(:path_info)
            new_path = Dragoman::Translator.translate_path new_path, locale
            new_conditions[:path_info] = new_path
            new_conditions[:parsed_path_info] = Journey::Parser.new.parse new_path
          end
          new_requirements[:locale] = locale
          add_route_without_localization app, new_conditions, new_requirements, defaults.dup, new_name, anchor
        end
      else
        add_route_without_localization app, conditions, requirements, defaults, name, anchor
      end
    end

  end
end
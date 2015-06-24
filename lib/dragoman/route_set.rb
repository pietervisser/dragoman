module Dragoman
  module RouteSet

    def self.included(base)
      base.send :alias_method_chain, :add_route, :localization
    end

    def add_route_with_localization(app, conditions = {}, requirements = {}, defaults = {}, name = nil, anchor = true)
      dragoman_options = defaults.delete :dragoman_options
      path_helpers, url_helpers = helper_modules
      if dragoman_options
        Dragoman::UrlHelpers.add_untranslated_helpers name, path_helpers, url_helpers if name
        dragoman_options[:locales].each do |locale|
          new_conditions = conditions.dup
          new_requirements = requirements.dup
          new_defaults = defaults.dup

          new_name = name ? "#{name}_#{locale}" : nil
          new_name = nil if new_name && named_routes.routes[new_name.to_sym] # Why is this necessary

          if new_path = new_conditions.delete(:path_info)
            new_path = Dragoman::Translator.translate_path new_path, locale
            new_conditions[:path_info] = new_path
            new_conditions[:parsed_path_info] = Dragoman::Journey::Parser.new.parse new_path if new_conditions[:parsed_path_info]
          end
          new_requirements[:locale] = locale.to_s
          new_defaults[:locale] = locale.to_s
          add_route_without_localization app, new_conditions, new_requirements, new_defaults, new_name, anchor
        end
      else
        add_route_without_localization app, conditions, requirements, defaults, name, anchor
      end
    end

    private

    def helper_modules
      named_routes.respond_to?(:path_helpers_module) ? [named_routes.path_helpers_module, named_routes.url_helpers_module] : [named_routes.module, named_routes.module]
    end

  end
end
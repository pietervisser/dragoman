module Dragoman
  module Mapper

    def self.included(base)
      base.send :alias_method_chain, :add_route, :localization
      base.send :alias_method_chain, :scope, :localization

      base.send :alias_method_chain, :resources, :localization
      base::Mapping.extend Mapping
      base::Mapping.class_eval do
        class << self
          alias_method_chain :build, :localization
        end
      end

    end

    module Mapping
      def build_with_localization scope, set, path, as, options
        if options[:locale]
          Dragoman::UrlHelpers.add_untranslated_helpers as, set if as
          as = "#{as}_#{options[:locale]}" if as.present?
          as = nil if as && set.named_routes.routes[as.to_sym] # TODO: why do we need to set as to nil?
        end
        build_without_localization scope, set, path, as, options
      end
    end

    private

    def localize
      @current_locale = nil
      locales = ['nl', 'en']
      locales.each do |locale|
        @current_locale = locale
        yield
      end
      @current_locale = nil
    end

    def add_route_with_localization(action, options)
      if @current_locale
        options[:path] = Dragoman::Translator.translate_path(action, @current_locale) unless canonical_action?(action)
        options[:locale] = @current_locale
      end
      add_route_without_localization action, options
    end

    def scope_with_localization(*args, &block)
      if @current_locale
        options = args.extract_options!.dup
        if options[:path] || args.any?
          options[:path] = Dragoman::Translator.translate_path(options[:path] || args.flatten.join('/'), @current_locale)
        end
        scope_without_localization options, &block
      else
        scope_without_localization *args, &block
      end
    end

    def resources_with_localization(*resources, &block)
      options = resources.extract_options!.dup
      if @current_locale
        options[:path] = Dragoman::Translator.translate_path(resources.last, @current_locale)
      end
      resources_without_localization(*resources, options, &block)
    end

  end
end
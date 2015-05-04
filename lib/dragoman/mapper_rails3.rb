module Dragoman

  module MapperRails3
    include Mapper

    def self.included(base)
      base.send :alias_method_chain, :add_route, :localization
      base.send :alias_method_chain, :scope, :localization

      base.send :alias_method_chain, :resources, :localization

      base::Mapping.send :include,  MappingRails3
    end

    module MappingRails3
      def self.included(base)
        base.send :alias_method_chain, :to_route, :localization
      end

      def to_route_with_localization
        if @options[:locale]
          Dragoman::UrlHelpers.add_untranslated_helpers @options[:as], @set.named_routes.module, @set.named_routes.module if @options[:as]
          @options[:as] = "#{@options[:as]}_#{@options[:locale]}" if @options[:as].present?
          @options[:as] = nil if @options[:as] && @set.named_routes.routes[@options[:as].to_sym] # TODO: why do we need to set as to nil?
        end
        to_route_without_localization
      end
    end

    def add_route_with_localization(action, options)
      if @current_locale
        options[:path] = Dragoman::Translator.translate_path(options[:path] || action, @current_locale) unless canonical_action?(action, true)
        options[:locale] = @current_locale
      end
      add_route_without_localization action, options
    end

  end
end
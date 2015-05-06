module Dragoman
  class TranslationVisitor < Dragoman::Journey::Visitors::String

    def initialize locale
      @locale = locale
      super()
    end

    def visit_LITERAL node
      translation = I18n.t node, scope: :routes, default: node.to_s, locale: @locale, fallback: true # NOTE: when fallback is true, fallbacks will NOT be used
      translation.present? ? translation : node
    end

  end
end
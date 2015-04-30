module Dragoman
  class TranslationVisitor < ActionDispatch::Journey::Visitors::String

    def initialize locale
      @locale = locale
      super()
    end

    def visit_LITERAL node
      I18n.t node, scope: :routes, default: node.to_s, locale: @locale
    end

  end
end
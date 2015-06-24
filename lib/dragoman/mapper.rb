module Dragoman
  module Mapper
    def localize
      locales = I18n.available_locales
      unscoped_locales = [I18n.default_locale]
      scoped_locales = locales - unscoped_locales
      scope ':locale', shallow_path: ':locale', defaults: {dragoman_options: {locales: scoped_locales}} do
        yield
      end
      defaults dragoman_options: {locales: unscoped_locales} do
        yield
      end
      @locales = nil
    end
  end
end
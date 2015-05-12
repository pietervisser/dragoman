module Dragoman
  module Mapper
    def localize
      @locales = I18n.available_locales
      scope '(:locale)', shallow_path: '(:locale)', defaults: {dragoman_options: {locales: @locales}} do
        yield
      end
      @locales = nil
    end
  end
end
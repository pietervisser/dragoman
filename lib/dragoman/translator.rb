module Dragoman

  class Translator

    def self.translate_path path, locale
      return path if path.blank?
      parsed_path = Dragoman::Journey::Parser.new.parse(path.to_s)
      Dragoman::TranslationVisitor.new(locale).accept(parsed_path)
    end

  end

end
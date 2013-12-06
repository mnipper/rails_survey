module Translatable
  extend ActiveSupport::Concern

  def has_translation_for?(language)
    self.translations.find_by_language(language)
  end

  def translated_for(language, field)
    self.translations.find_by_language(language).send(field) if has_translation_for? language
  end
end

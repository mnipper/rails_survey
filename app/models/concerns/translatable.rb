module Translatable
  extend ActiveSupport::Concern

  def has_translation_for?(language)
    self.translations.find_by_language(language)
  end

  def translated_for(language, field)
    self.translations.find_by_language(language).send(field) if has_translation_for? language
  end

  def add_or_update_translation_for(language, translated_text)
    translated = translations.where(language: language).first_or_initialize
    translated.text = translated_text
    translated.save
  end
end

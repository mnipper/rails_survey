module Translatable
  extend ActiveSupport::Concern

  def has_translation_for?(language)
    self.translations.find_by_language(language)
  end

  def translated_for(language)
    self.translations.find_by_language(language).text if has_translation_for? language
  end
end

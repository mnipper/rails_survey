module LanguageAssignable
  extend ActiveSupport::Concern

  included do
    validates :language, presence: true, allow_blank: false
    validates_format_of :language, with: /\A[a-z]{2}\z/, message: 'not valid lower-case ISO-639-1 code'
  end
end

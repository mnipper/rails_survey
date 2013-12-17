module Alignable
  extend ActiveSupport::Concern

  included do
    before_validation :set_language_alignment
    validates :alignment, presence: true, allow_blank: false,
                inclusion: { in: %w(left right), message: 'must be left or right' }
  end

  private
  def set_language_alignment
    if Settings.right_align_languages.include? self.language
      self.alignment = 'right'
    else
      self.alignment = 'left'
    end
  end
end

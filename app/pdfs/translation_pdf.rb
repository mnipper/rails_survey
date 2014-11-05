class TranslationPdf < Prawn::Document
  def initialize(instrument_translation)
    super()
    @instrument_translation = instrument_translation
    @instrument             = instrument_translation.instrument
    @language               = @instrument_translation.language
    @version                = @instrument.current_version_number

    header
    content
  end

  def display_name
    "#{@instrument.title}_#{@version}_#{@language}.pdf"
  end

  private
    def header
      after_title_margin = 15

      text "#{@instrument_translation.title} v#{@version}", size: 20, style: :bold
      text "#{@language}"
      move_down after_title_margin
    end
   
    def content
      @instrument.questions.each do |question|
        format_question(question)
      end
    end

    def format_question(question)
      instruction_question_margin = 10

      number_question(question)

      if question.has_translation_for?(@language)
        text question.instructions, style: :italic
        move_down instruction_question_margin 
        text Sanitize.fragment(question.translated_for(@language, :text))
        draw_options(question) if question.has_options?
      end

      pad_after_question(question)
    end 

    def number_question(question)
      left_margin = 30

      text "#{question.number_in_instrument}.)", size: 18, style: :bold
      draw_text question.question_type,       at: [left_margin, cursor + 15], size: 10, style: :bold
      draw_text question.question_identifier, at: [left_margin, cursor + 5],  size: 10, style: :bold
    end

    def draw_options(question)
      left_margin = 10
      circle_size = 5
      after_option_margin = 15

      question.options.each do |option|
        stroke_circle [left_margin, cursor - 5], circle_size
        draw_text option.translated_for(@language, :text), at: [left_margin + 10, cursor - 10]
        move_down after_option_margin 
      end

      if question.has_other?
        stroke_circle [left_margin, cursor - 5], circle_size 
        draw_text "____________________________________________", at: [left_margin + 10, cursor - 10]
      end
    end

    def pad_after_question(question)
      if question.question_type == "FREE_RESPONSE"
        move_down 200
      else
        move_down 50
      end
    end
end

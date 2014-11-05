class TranslationPdf < Prawn::Document
  def initialize(instrument_translation)
    super()
    @instrument_translation = instrument_translation
    @instrument = instrument_translation.instrument
    header
    content
  end

  def display_name
    "#{@instrument.title}_#{@instrument.current_version_number}_#{@instrument_translation.language}.pdf"
  end

  private
    def header
      text "#{@instrument_translation.title} v#{@instrument.current_version_number}", size: 20, style: :bold
      text "#{@instrument_translation.language}"
      move_down 25 
    end
   
    def content
      @instrument.questions.each do |question|
        format_question(question)
      end
    end

    def format_question(question)
      number_question(question)

      if question.has_translation_for?(@instrument_translation.language)
        text question.instructions, style: :italic
        move_down 10
        text Sanitize.fragment(question.translated_for(@instrument_translation.language, :text))
        draw_options(question) if question.has_options?
      end

      pad_after_question(question)
    end 

    def number_question(question)
      text "#{question.number_in_instrument}.)", size: 18, style: :bold
      draw_text question.question_type, at: [30, cursor + 15], size: 10, style: :bold
      draw_text question.question_identifier, at: [30, cursor + 5], size: 10, style: :bold
    end

    def draw_options(question)
      question.options.each do |option|
        stroke_circle [10, cursor - 5], 5
        draw_text option.translated_for(@instrument_translation.language, :text), at: [20, cursor - 10]
        move_down 15
      end

      if question.has_other?
        stroke_circle [10, cursor - 5], 5
        draw_text "____________________________________________", at: [20, cursor - 10]
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

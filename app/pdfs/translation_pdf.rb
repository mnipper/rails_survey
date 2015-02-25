class TranslationPdf < Prawn::Document

  OptionLeftMargin = 5
  QuestionLeftMargin = 30
  AfterOptionMargin = 15
  InstructionQuestionMargin = 10
  AfterTitleMargin = 15
  CircleSize = 5
  SquareSize = 5
  AfterHorizontalRuleMargin = 10

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
      text "#{@instrument_translation.title} v#{@version}", size: 20, style: :bold
      text "#{@language}"
      move_down AfterTitleMargin
    end
   
    def content
      @instrument.questions.each do |question|
        format_question(question)
        text special_responses
        stroke_horizontal_rule
        move_down AfterHorizontalRuleMargin
      end
    end

    def format_question(question)
      number_question(question)

      if question.has_translation_for?(@language)
        text Sanitize.fragment(question.instructions), style: :italic
        move_down InstructionQuestionMargin 
        text Sanitize.fragment(question.translated_for(@language, :text))
        draw_options(question) if question.has_options?
      end

      pad_after_question(question)
    end 

    def number_question(question)
      text "#{question.number_in_instrument}.)", size: 18, style: :bold
      number_padding = question.number_in_instrument.to_s.length * 10
      draw_text question.question_type,       at: [QuestionLeftMargin + number_padding, cursor + 15], size: 10, style: :bold
      draw_text question.question_identifier, at: [QuestionLeftMargin + number_padding, cursor + 5],  size: 10, style: :bold
    end

    def draw_options(question)
      question.options.each do |option|
        draw_option(option) { stroke_circle [OptionLeftMargin, cursor - 5], CircleSize } if question.select_one_variant?
        draw_option(option) { stroke_rectangle [OptionLeftMargin, cursor - 5], SquareSize, SquareSize } if question.select_multiple_variant?
        draw_line_option(option) if question.question_type == "LIST_OF_TEXT_BOXES"
      end

      draw_other(question) if question.has_other?
    end

    def pad_after_question(question)
      if question.question_type == "FREE_RESPONSE"
        move_down 200
      else
        move_down 50
      end
    end

    def draw_option(option, &block)
      block.call
      span(500, position: OptionLeftMargin + 10) do
        if option.next_question?
          next_question = Question.find_by_question_identifier(option.next_question)
          if next_question.nil?
            text "#{option.translated_for(@language, :text)} (<color rgb='ff0000'>Error Locating Question #{option.next_question} for skip pattern!</color>)", :inline_format => true
          else
            text "#{option.translated_for(@language, :text)} (#{skip_to} ##{next_question.number_in_instrument})"
          end
        else
          text option.translated_for(@language, :text)
        end
      end
    end

    def draw_other(question)
      stroke_circle [OptionLeftMargin, cursor - 5], CircleSize if question.question_type == "SELECT_ONE_WRITE_OTHER"
      stroke_rectangle [OptionLeftMargin, cursor - 5], SquareSize, SquareSize if question.question_type == "SELECT_MULTIPLE_WRITE_OTHER"
      draw_text "____________________________________________", at: [OptionLeftMargin + 10, cursor - 10]
    end

    def draw_line_option(option)
      draw_text "#{option.translated_for(@language, :text)} _________________________________", at: [OptionLeftMargin, cursor - 5]
      move_down AfterOptionMargin
    end

    def skip_to
      case @language
      when 'en'
        'Skip pattern: Skip to'
      when 'es'
        'Modelo de Omisión: vaya al #'
      else
        'Skip pattern: Skip to'
      end
    end

    def special_responses
      case @language
      when 'en'
        'Special Response (circle one):   RF   DK   SK   NA'
      when 'es'
        'Respuesta Especial (circule uno):   RC   NS   SP   NA'
      else
        'Special Response (circle one):   RF   DK   SK   NA'
      end
    end
end

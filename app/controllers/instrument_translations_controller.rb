class InstrumentTranslationsController < ApplicationController
  after_action :verify_authorized
  
  def index
    @instrument = current_project.instruments.find(params[:instrument_id])
    @instrument_translations = @instrument.translations
    authorize @instrument_translations
  end

  def show
    @instrument = current_project.instruments.find(params[:instrument_id])
    @instrument_translation = @instrument.translations.find(params[:id])
    authorize @instrument_translation

    respond_to do |format|
      format.html
      format.pdf do
        pdf = TranslationPdf.new(@instrument_translation)
        send_data pdf.render, filename: pdf.display_name, type: 'application/pdf'
      end
    end
  end

  def new
    @project = current_project
    @instrument = current_project.instruments.find(params[:instrument_id])
    @instrument_translation = @instrument.translations.new
    authorize @instrument_translation
  end

  def create
    @instrument = current_project.instruments.find(params[:instrument_id])
    @instrument_translation = @instrument.translations.new(params[:instrument_translation])
    authorize @instrument_translation
    if @instrument_translation.save
      update_translations(params, @instrument, @instrument_translation)
      redirect_to project_instrument_instrument_translation_path(current_project, @instrument, @instrument_translation),
        notice: "Successfully created instrument translation."
    else
      render :new
    end
  end

  def edit
    @instrument = current_project.instruments.find(params[:instrument_id])
    @instrument_translation = @instrument.translations.find(params[:id])
    @project = current_project
    authorize @instrument_translation
  end

  def update
    @instrument = current_project.instruments.find(params[:instrument_id])
    @instrument_translation = @instrument.translations.find(params[:id])
    authorize @instrument_translation
    update_translations(params, @instrument, @instrument_translation)
    if @instrument_translation.update_attributes(params[:instrument_translation])
      redirect_to project_instrument_instrument_translation_path(current_project, @instrument, @instrument_translation),
        notice: "Successfully updated instrument translation."
    else
      render :edit
    end
  end

  def destroy
    @instrument = current_project.instruments.find(params[:instrument_id])
    @instrument_translation = @instrument.translations.find(params[:id])
    authorize @instrument_translation
    @instrument_translation.destroy
    redirect_to project_instrument_instrument_translations_url, notice: "Successfully destroyed instrument translation."
  end

  private

  def update_translations(params, instrument, instrument_translation)
    language = instrument_translation.language

    params[:question_translations].each_pair do |id, translation|
      question = instrument.questions.find(id)
      q_translation = question.has_translation_for?(language)
      if q_translation and q_translation.text != translation
        q_translation.update_attribute(:question_changed, false)
      end
      question.add_or_update_translation_for(language, translation, :text)
    end if params.has_key? :question_translations

    params[:validation_translations].each_pair do |id, translation|
      question = instrument.questions.find(id)
      question.add_or_update_translation_for(language, translation, :reg_ex_validation_message)
    end if params.has_key? :validation_translations

    params[:option_translations].each_pair do |id, translation|
      option = Option.find(id)
      o_translation = option.has_translation_for?(language)
      if o_translation and o_translation.text != translation
        o_translation.update_attribute(:option_changed, false)
      end
      option.add_or_update_translation_for(language, translation, :text)
    end if params.has_key? :option_translations
    
    params[:section_translations].each_pair do |id, translation|
      section = instrument.sections.find(id)
      s_translation = section.has_translation_for?(language)
      if s_translation and s_translation.text != translation
        s_translation.update_attribute(:section_changed, false)
      end
      section.add_or_update_translation_for(language, translation, :text)
    end if params.has_key? :section_translations
  end
end

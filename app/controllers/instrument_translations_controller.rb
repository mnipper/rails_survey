class InstrumentTranslationsController < ApplicationController
  def index
    @instrument = current_project.instruments.find(params[:instrument_id])
    @instrument_translations = @instrument.translations.to_a
  end

  def show
    @instrument = current_project.instruments.find(params[:instrument_id])
    @instrument_translation = @instrument.translations.find(params[:id])
  end

  def new
    @project = current_project
    @instrument = current_project.instruments.find(params[:instrument_id])
    @instrument_translation = @instrument.translations.new
  end

  def create
    @instrument = current_project.instruments.find(params[:instrument_id])
    @instrument_translation = @instrument.translations.new(params[:instrument_translation])
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
  end

  def update
    @instrument = current_project.instruments.find(params[:instrument_id])
    @instrument_translation = @instrument.translations.find(params[:id])
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
    @instrument_translation.destroy
    redirect_to project_instrument_instrument_translations_url, notice: "Successfully destroyed instrument translation."
  end

  private

  def update_translations(params, instrument, instrument_translation)
    language = instrument_translation.language

    params[:question_translations].each_pair do |id, translation|
      question = instrument.questions.find(id)
      question.add_or_update_translation_for(language, translation, :text)
    end if params.has_key? :question_translations

    params[:validation_translations].each_pair do |id, translation|
      question = instrument.questions.find(id)
      question.add_or_update_translation_for(language, translation, :reg_ex_validation_message)
    end if params.has_key? :validation_translations

    params[:option_translations].each_pair do |id, translation|
      option = Option.find(id)
      option.add_or_update_translation_for(language, translation, :text)
    end if params.has_key? :option_translations
  end
end

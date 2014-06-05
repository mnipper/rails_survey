class DeleteQuestionWorker
  include Sidekiq::Worker

  def perform(instrument_id, question_number)
    instrument = Instrument.find instrument_id
    instrument.reorder_questions_after_delete(question_number)
  end
end

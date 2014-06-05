class ReorderQuestionsWorker
  include Sidekiq::Worker

  def perform(instrument_id, old_number, new_number)
    instrument = Instrument.find instrument_id
    instrument.reorder_questions(old_number, new_number)
  end
end

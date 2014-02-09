class InstrumentVersion
  attr_accessor :instrument, :version

  def method_missing(method, *args, &block)
    if Instrument.method_defined?(method) 
      if @version
        @version.reify.send(method, *args, &block)
      else
        @instrument.send(method, *args, &block)
      end
    else
      super
    end
  end

  def self.build(params = {})
    @instrument = Instrument.find(params[:instrument_id])
    instrument_version = InstrumentVersion.new
    instrument_version.instrument = @instrument

    unless @instrument.current_version_number == params[:version_number].to_i
      @version = @instrument.versions[params[:version_number].to_i]
      instrument_version.version = @version
    end

    instrument_version
  end
  
  def questions
    return @instrument.questions unless @version
    questions = []
    @version.reify.questions.each do |question|
      if versioned(question)
        questions << versioned(question)
        options = options_for_question(versioned(question))
        question.define_singleton_method(:options) { options }
      end
    end
    questions
  end

  def versioned(object)
    return object unless @version
    object.version_at(@version.created_at)
  end

  private
  def options_for_question(question)
    return question.options unless @version
    options = []
    versioned(question).options.each do |option|
      options << versioned(option) if versioned(option)
    end
    options
  end
end

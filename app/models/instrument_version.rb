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
    if @instrument.current_version_number == params[:version_number].to_i
      @instrument
    else
      @version = @instrument.versions[params[:version_number].to_i]
      instrument_version = InstrumentVersion.new
      instrument_version.instrument = @instrument
      instrument_version.version = @version
      instrument_version
    end
  end
  
  def questions
    return @instrument.questions unless @version
    questions = []
    @version.reify.questions.each do |question|
      questions << versioned(question) if versioned(question)
    end
    questions
  end

  def options_for_question(question)
    options = []
    versioned(question).options.each do |option|
      options << versioned(option) if versioned(option)
    end
    options
  end

  def versioned(object)
    return object unless @version
    object.version_at(@version.created_at)
  end
end

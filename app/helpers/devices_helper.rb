module DevicesHelper
  def survey_count(survey)
    Survey.find(:all, conditions: ["device_identifier = ?", survey.device_identifier]).count
  end

end

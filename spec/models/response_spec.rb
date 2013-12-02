# == Schema Information
#
# Table name: responses
#
#  id             :integer          not null, primary key
#  question_id    :integer
#  text           :string(255)
#  other_response :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  survey_uuid    :string(255)
#

require "spec_helper"

describe Response do
  it { should respond_to(:question) }
  it { should respond_to(:survey) }

  describe "When there is a valid response" do
    before :each do
      @response = create(:response)
    end

    it "should return the survey by UUID" do
      @survey = create(:survey)
      @response.survey_uuid = @survey.uuid
      @response.survey.should == @survey
    end

    it "should return text for to_s if no options" do
      @response.to_s.should == @response.text
    end

    it "should return option text for to_s if options" do
      question = build(:question)
      question.options << build(:option)
      @response.to_s.should == question.options.first.to_s
    end

    it "should export correctly" do
      out = []
      Response.export(out)
      out.should == [
        ["qid",
          "instrument_id",
          "instrument_title",
          "survey_uuid",
          "device_id",
          "response",
          "other_response"
        ],
        ["q1",
          @response.instrument.id,
          @response.instrument.title,
          @response.survey.uuid,
          @response.survey.device.identifier,
          "a",
          'other']
        ]
    end
  end
end

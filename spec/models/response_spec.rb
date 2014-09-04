# == Schema Information
#
# Table name: responses
#
#  id                  :integer          not null, primary key
#  question_id         :integer
#  text                :text
#  other_response      :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  survey_uuid         :string(255)
#  special_response    :string(255)
#  time_started        :datetime
#  time_ended          :datetime
#  question_identifier :string(255)
#  uuid                :string(255)
#  device_user_id      :integer
#  question_version    :integer          default(-1)
#

require "spec_helper"

describe Response do
  it { should respond_to(:question) }
  it { should respond_to(:survey) }

  describe "When there is a valid response" do
    before :each do
      @response = create(:response)
    end

    it "should be valid" do
      @response.should be_valid
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
          "short_qid",
          "instrument_id",
          "instrument_version_number",
          "question_version_number",
          "instrument_title",
          "survey_id",
          "survey_uuid",
          "device_id",
          "device_uuid",
          "question_type",
          "question_text",
          "response",
          "response_labels",
          "special_response",
          "other_response",
          "response_time_started",
          "response_time_ended",
          "device_user_id",
          "device_user_username"
        ],
        [@response.question_identifier,
          "q_#{@response.question_id}",
          @response.instrument.id,
          1,
          1,
          @response.survey.instrument_title,
          @response.survey.id,
          @response.survey.uuid,
          @response.survey.device.id,
          @response.survey.device_uuid,
          @response.question.question_type,
          Sanitize.fragment(@response.versioned_question.try(:text)),
          "a",
          @response.option_labels,
          "SKIP",
          'other',
          @response.time_started,
          @response.time_ended,
          @response.device_user.id,
          @response.device_user.username]
        ]
    end

    describe "validations" do
      it "should require a question" do
        @response.question_id = nil
        @response.should_not be_valid
      end

      it "should require a survey" do
        @response.survey_uuid = nil
        @response.should_not be_valid
      end
    end
  end
end

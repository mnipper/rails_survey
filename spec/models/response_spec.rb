# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  question_id      :integer
#  text             :string(255)
#  other_response   :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  survey_uuid      :string(255)
#  special_response :string(255)
#  time_started     :datetime
#  time_ended       :datetime
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
          "instrument_id",
          "instrument_version_number",
          "instrument_title",
          "survey_uuid",
          "device_id",
          "response",
          "special_response",
          "other_response"
        ],
        [@response.question.question_identifier,
          @response.instrument.id,
          1,
          @response.instrument.title,
          @response.survey.uuid,
          @response.survey.device.identifier,
          "a",
          "SKIP",
          'other']
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

  describe "versioned response", versioning: true do
    before :each do
      @test_response = create(:response)
    end

    it "should return text" do
      @test_response.versioned_response.should == @test_response.text
    end

    it "should return versioned option text" do
      @test_response.versioned_response.should == 'a' #TODO fix/understand factory associations
    end
  end

end

require "spec_helper"

describe Response do
  before :each do
    @response = build(:response)
    @survey = create(:survey)
  end

  it { should respond_to(:question) }
  it { should respond_to(:survey) }

  it "should return the survey by UUID" do
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
end

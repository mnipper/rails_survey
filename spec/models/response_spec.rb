require "spec_helper"

describe Response do
  before :each do
    @response = Response.new
  end

  it { should respond_to(:question) }
  it { should respond_to(:survey) }

  it "should return the survey by UUID" do
    example_uuid = "00000000-0000-0000-0000-000000000000"
    survey = Survey.create(uuid: example_uuid)
    @response.survey_uuid = example_uuid
    @response.survey.should == survey
    survey.destroy
  end

  it "should return text for to_s if no options" do
    @response.question = Question.new
    @response.text = "the_text"
    @response.to_s.should == "the_text"
  end

  it "should return option text for to_s if options" do
    question = Question.new
    option = Option.new(text: 'option_1')
    question.options = [option]
    @response.question = question
    @response.text = '0'
    @response.to_s.should == option
  end
end

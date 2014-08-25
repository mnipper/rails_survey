require 'spec_helper'

describe "Responses API" do
  before :each do
    @question = FactoryGirl.create(:question)
    @survey = FactoryGirl.create(:survey)
    @response = FactoryGirl.build(:response)
    @api_key = FactoryGirl.create(:api_key)
    @device_user = FactoryGirl.create(:device_user)
  end

  it 'returns a successful response if response is valid' do
    post "/api/v1/projects/#{@question.instrument.project.id}/responses?access_token=#{@api_key.access_token}",
      response:
        {
          'question_id' => @question.id,
          'survey_uuid' => @survey.uuid,
          'device_user_id' => @device_user.id
        }
    expect(response).to be_success
  end

  it 'returns an unsuccessful response if missing question id' do
    post "/api/v1/projects/#{@question.instrument.project.id}/responses?access_token=#{@api_key.access_token}",
      response:
        {
          'survey_uuid' => @survey.uuid
        }
    expect(response).to_not be_success
  end

  it 'returns an unsuccessful response if missing survey uuid' do
    post "/api/v1/projects/#{@question.instrument.project.id}/responses?access_token=#{@api_key.access_token}",
      response:
        {
          'question_id' => @question.id
        }
    expect(response).to_not be_success
  end

  it 'returns an unsuccessful response if invalid survey uuid' do
    post "/api/v1/projects/#{@question.instrument.project.id}/responses?access_token=#{@api_key.access_token}",
      response:
        {
          'question_id' => @question.id,
          'survey_uuid' => '-1'
        }
    expect(response).to_not be_success
  end

  it 'returns an unsuccessful response if invalid question id' do
    post "/api/v1/projects/#{@question.instrument.project.id}/responses?access_token=#{@api_key.access_token}",
      response:
        {
          'question_id' => '-1',
          'survey_uuid' => @survey.uuid 
        }
    expect(response).to_not be_success
  end

  it 'should not respond to a get request' do
    lambda { get "/api/v1/projects/#{@question.instrument.project.id}/resposnes?access_token=#{@api_key.access_token}" }.should raise_error
  end

  it 'should require an access token' do
    post "/api/v1/projects/#{@question.instrument.project.id}/responses",
      response:
        {
          'question_id' => @question.id,
          'survey_uuid' => @survey.uuid
        }
        expect(response.response_code).to eq(Rack::Utils::SYMBOL_TO_STATUS_CODE[:unauthorized])
  end

  it 'should not allow an outdated android app to send responses' do
    Settings.minimum_android_version_code = 2
    post "/api/v1/projects/#{@question.instrument.project.id}/responses?access_token=#{@api_key.access_token}&version_code=1",
      response:
        {
          'question_id' => @question.id,
          'survey_uuid' => @survey.uuid
        }
    expect(response.response_code).to eq(Rack::Utils::SYMBOL_TO_STATUS_CODE[:upgrade_required])
  end

  it 'should allow a current android app to send responses' do
    Settings.minimum_android_version_code = 2
    post "/api/v1/projects/#{@question.instrument.project.id}/responses?access_token=#{@api_key.access_token}&version_code=2",
      response:
        {
          'question_id' => @question.id,
          'survey_uuid' => @survey.uuid
        }
    expect(response).to be_success
  end
end

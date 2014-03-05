require 'spec_helper'

describe "Surveys API" do
  before :each do
    @instrument = FactoryGirl.create(:instrument)
    @device = FactoryGirl.create(:device)
    @survey = FactoryGirl.build(:survey)
    @api_key = FactoryGirl.create(:api_key)
  end

  it 'returns a successful response if survey is valid' do
    post "/api/v1/projects/#{@instrument.project.id}/surveys?access_token=#{@api_key.access_token}",
      survey:
        {
          'instrument_id' => @instrument.id,
          'instrument_version_number' => 0,
          'device_uuid' => @survey.uuid, 
          'device_label' => 'label',
          'uuid' => @survey.uuid
        }
    expect(response).to be_success
  end

  it 'returns an invalid response if survey is missing device identifier' do
    post "/api/v1/projects/#{@instrument.project.id}/surveys?access_token=#{@api_key.access_token}",
      survey:
        {
          'instrument_id' => @instrument.id,
          'instrument_version_number' => 0,
          'uuid' => @survey.uuid
        }
    expect(response).to_not be_success
  end

  it 'returns an invalid response if survey is missing instrument id' do
    post "/api/v1/projects/#{@instrument.project.id}/surveys?access_token=#{@api_key.access_token}",
      survey:
        {
          'instrument_version_number' => 0,
          'device_uuid' => @device.identifier, 
          'uuid' => @survey.uuid
        }
    expect(response).to_not be_success
  end

  it 'returns an invalid response if survey is missing uuid' do
    post "/api/v1/projects/#{@instrument.project.id}/surveys?access_token=#{@api_key.access_token}",
      survey:
        {
          'instrument_id' => @instrument.id,
          'instrument_version_number' => 0,
          'device_uuid' => @device.identifier, 
        }
    expect(response).to_not be_success
  end

  it 'returns an invalid response if survey is missing instrument version number' do
    post "/api/v1/projects/#{@instrument.project.id}/surveys?access_token=#{@api_key.access_token}",
      survey:
        {
          'instrument_id' => @instrument.id,
          'device_uuid' => @device.identifier, 
          'uuid' => @survey.uuid
        }
    expect(response).to_not be_success
  end

  it 'should not respond to a get request' do
    lambda { get "/api/v1/projects/#{@instrument.project.id}/surveys?access_token=#{@api_key.access_token}" }.should raise_error
  end

  it 'should require an access token' do
    post "/api/v1/projects/#{@instrument.project.id}/surveys",
      survey:
        {
          'instrument_id' => @instrument.id,
          'instrument_version_number' => 0,
          'device_uuid' => @device.identifier,
          'uuid' => @survey.uuid
        }
    expect(response.response_code).to eq(Rack::Utils::SYMBOL_TO_STATUS_CODE[:unauthorized])
  end

  it 'should not allow an outdated android app to send surveys' do
    Settings.minimum_android_version_code = 2
    post "/api/v1/projects/#{@instrument.project.id}/surveys?access_token=#{@api_key.access_token}&version_code=1",
      survey:
        {
          'instrument_id' => @instrument.id,
          'instrument_version_number' => 0,
          'device_uuid' => @device.identifier,
          'uuid' => @survey.uuid
        }
    expect(response.response_code).to eq(Rack::Utils::SYMBOL_TO_STATUS_CODE[:upgrade_required])
  end

  it 'should allow a current android app to send surveys' do
    Settings.minimum_android_version_code = 2
    post "/api/v1/projects/#{@instrument.project.id}/surveys?access_token=#{@api_key.access_token}&version_code=2",
      survey:
        {
          'instrument_id' => @instrument.id,
          'instrument_version_number' => 0,
          'device_uuid' => @device.identifier,
          'uuid' => @survey.uuid
        }
    expect(response).to be_success
  end
end

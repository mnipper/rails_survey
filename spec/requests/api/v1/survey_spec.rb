require 'spec_helper'

describe "Surveys API" do
  before :each do
    @instrument = FactoryGirl.create(:instrument)
    @device = FactoryGirl.create(:device)
    @survey = FactoryGirl.build(:survey)
  end

  it 'returns a successful response if survey is invalid' do
    post '/api/v1/surveys',
      survey:
        {
          'instrument_id' => @instrument.id,
          'instrument_version_number' => 0,
          'device_identifier' => @device.identifier, 
          'uuid' => @survey.uuid
        }
    expect(response).to be_success
  end

  it 'returns an invalid response if survey is missing device identifier' do
    post '/api/v1/surveys',
      survey:
        {
          'instrument_id' => @instrument.id,
          'instrument_version_number' => 0,
          'uuid' => @survey.uuid
        }
    expect(response).to_not be_success
  end

  it 'returns an invalid response if survey is missing instrument id' do
    post '/api/v1/surveys',
      survey:
        {
          'instrument_version_number' => 0,
          'device_identifier' => @device.identifier, 
          'uuid' => @survey.uuid
        }
    expect(response).to_not be_success
  end

  it 'returns an invalid response if survey is missing uuid' do
    post '/api/v1/surveys',
      survey:
        {
          'instrument_id' => @instrument.id,
          'instrument_version_number' => 0,
          'device_identifier' => @device.identifier, 
        }
    expect(response).to_not be_success
  end

  it 'returns an invalid response if survey is missing instrument version number' do
    post '/api/v1/surveys',
      survey:
        {
          'instrument_id' => @instrument.id,
          'device_identifier' => @device.identifier, 
          'uuid' => @survey.uuid
        }
    expect(response).to_not be_success
  end

  it 'should not respond to a get request' do
    lambda { get '/api/v1/surveys' }.should raise_error
  end
end

require 'spec_helper'

describe "Options API" do
  before :each do
    @api_key = create(:api_key)
    @project = create(:project)
    @instrument = create(:instrument, project: @project)
    @question = create(:question, instrument: @instrument)
    @options = FactoryGirl.create_list(:option, 5, question: @question)
    get "/api/v1/projects/#{@project.id}/options?access_token=#{@api_key.access_token}"
    @json = JSON.parse(response.body)
  end

  it 'returns a successful response' do
    expect(response).to be_success
  end

  it 'receives the correct number of options' do
    expect(@json.length).to eq(5)
  end

  it 'has a text attribute' do
    @json.first.should have_key('text')
  end

  it 'has a translations attribute' do
    @json.first.should have_key('translations')
    @json.first['translations'].should be_a Array
  end

  it "has a question_id attribute" do
    @json.first.should have_key('question_id')
  end

  it "has a next_question attribute" do
    @json.first.should have_key('next_question')
  end

  it "has a number_in_question attribute" do
    @json.first.should have_key('number_in_question')
  end

  it "has a instrument_version attribute" do
    @json.first.should have_key('instrument_version')
  end

  describe "translation text" do
    before :each do
      @translation = create(:option_translation, option: @options.last)
      get "/api/v1/projects/#{@project.id}/options?access_token=#{@api_key.access_token}"
      @json = JSON.parse(response.body)
    end

    it "has the correct translation text" do
      @json.last['translations'].first['text'].should == @translation.text
    end

    it "has the correct translation text" do
      @json.last['translations'].first['language'].should == @translation.language
    end
  end

  it 'should require an access token' do
    get "/api/v1/projects/#{@options.first.question.project.id}/options"
    expect(response.response_code).to eq(Rack::Utils::SYMBOL_TO_STATUS_CODE[:unauthorized])
  end

  it 'should not allow an outdated android app to obtain options' do
    Settings.minimum_android_version_code = 2
    get "/api/v1/projects/#{@options.first.project.id}/options?access_token=#{@api_key.access_token}&version_code=1"
    expect(response.response_code).to eq(Rack::Utils::SYMBOL_TO_STATUS_CODE[:upgrade_required])
  end

  it 'should allow a current android app to obtain options' do
    Settings.minimum_android_version_code = 2
    get "/api/v1/projects/#{@options.first.project.id}/options?access_token=#{@api_key.access_token}&version_code=2"
    expect(response).to be_success
  end
end

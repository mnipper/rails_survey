require 'spec_helper'

describe "Questions API" do
  before :each do
    @api_key = create(:api_key)
    @project = create(:project)
    @instrument = create(:instrument, project: @project)
    @questions = FactoryGirl.create_list(:question, 5, instrument: @instrument)
    get "/api/v1/projects/#{@questions.first.project.id}/questions?access_token=#{@api_key.access_token}"
    @json = JSON.parse(response.body)
  end

  it 'returns a successful response' do
    expect(response).to be_success
  end

  it 'receives the correct number of questions' do
    expect(@json.length).to eq(5)
  end

  it 'has a text attribute' do
    @json.first.should have_key('text')
  end

  it 'has a reg ex validation attribute' do
    @json.first.should have_key('reg_ex_validation')
  end

  it 'has a translations attribute' do
    @json.first.should have_key('translations')
    @json.first['translations'].should be_a Array
  end

  it "has a question_identifier" do
    @json.first.should have_key('question_identifier')
    @json.first['question_identifier'].should == @questions.first.question_identifier
  end

  it 'has an option count attribute' do
    @json.first.should have_key('option_count')
  end

  it 'has an instrument version attribute' do
    @json.first.should have_key('instrument_version')
  end

  describe "translation text" do
    before :each do
      @translation = create(:question_translation, question: @questions.last)
      get "/api/v1/projects/#{@questions.first.project.id}/questions?access_token=#{@api_key.access_token}"
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
    get "/api/v1/projects/#{@questions.first.project.id}/questions"
    expect(response.response_code).to eq(Rack::Utils::SYMBOL_TO_STATUS_CODE[:unauthorized])
  end

  it 'should not allow an outdated android app to obtain questions' do
    Settings.minimum_android_version_code = 2
    get "/api/v1/projects/#{@questions.first.project.id}/questions?access_token=#{@api_key.access_token}&version_code=1"
    expect(response.response_code).to eq(Rack::Utils::SYMBOL_TO_STATUS_CODE[:upgrade_required])
  end

  it 'should allow a current android app to obtain questions' do
    Settings.minimum_android_version_code = 2
    get "/api/v1/projects/#{@questions.first.project.id}/questions?access_token=#{@api_key.access_token}&version_code=2"
    expect(response).to be_success
  end
end

require 'spec_helper'

describe "Instruments API" do
  before :each do
    @project = FactoryGirl.create(:project)
    @instruments = FactoryGirl.create_list(:instrument, 5, project: @project)
    @api_key = FactoryGirl.create(:api_key)
    get "/api/v1/projects/#{@project.id}/instruments?access_token=#{@api_key.access_token}"
    @json = JSON.parse(response.body)
  end

  it 'returns a successful response' do
    expect(response).to be_success
  end

  it 'receives the correct number of instruments' do
    expect(@json.length).to eq(5)
  end

  it 'has a language attribute' do
    @json.first.should have_key('language')
  end

  it 'has a translations attribute' do
    @json.first.should have_key('translations')
    @json.first['translations'].should be_a Array
  end

  it 'has a valid alignment' do
    @json.first.should have_key('alignment')
    @json.first['alignment'].should == 'left'
  end

  it "has a current_version_number" do
    @json.first.should have_key('current_version_number')
    @json.first['current_version_number'].should == 0
  end

  describe "translation text" do
    before :each do
      @translation = create(:instrument_translation)
      get "/api/v1/projects/#{@translation.instrument.project.id}/instruments?access_token=#{@api_key.access_token}"
      @json = JSON.parse(response.body)
    end

    it "has the correct translation title" do
      @json.last['translations'].first['title'].should == @translation.title
    end

    it "has the correct translation text" do
      @json.last['translations'].first['language'].should == @translation.language
    end

    it "has the correct translation alignment" do
      @json.last['translations'].first['alignment'].should == @translation.alignment
    end
  end

  it 'should require an access token' do
    get "/api/v1/projects/#{@project.id}/instruments"
    expect(response.response_code).to eq(Rack::Utils::SYMBOL_TO_STATUS_CODE[:unauthorized])
  end

  it 'should show all instruments' do
    @instruments.last.update_attributes!(published: false)
    get "/api/v1/projects/#{@project.id}/instruments?access_token=#{@api_key.access_token}"
    expect(JSON.parse(response.body).length).to eq(5)
  end

  it 'should not allow an outdated android app to obtain instruments' do
    Settings.minimum_android_version_code = 2
    get "/api/v1/projects/#{@project.id}/instruments?access_token=#{@api_key.access_token}&version_code=1"
    expect(response.response_code).to eq(Rack::Utils::SYMBOL_TO_STATUS_CODE[:upgrade_required])
  end

  it 'should allow a current android app to obtain instruments' do
    Settings.minimum_android_version_code = 2
    get "/api/v1/projects/#{@project.id}/instruments?access_token=#{@api_key.access_token}&version_code=2"
    expect(response).to be_success
  end
end

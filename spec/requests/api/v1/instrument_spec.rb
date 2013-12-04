require 'spec_helper'

describe "Instruments API" do
  before :each do
    FactoryGirl.create_list(:instrument, 5)
    get '/api/v1/instruments'
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
      get '/api/v1/instruments'
      @json = JSON.parse(response.body)
    end

    it "should add a new instrument for the translation" do
      expect(@json.length).to eq(6)
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
end

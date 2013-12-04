require 'spec_helper'

describe "Options API" do
  before :each do
    FactoryGirl.create_list(:option, 5)
    get '/api/v1/options'
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
end

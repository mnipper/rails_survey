require 'spec_helper'

describe "Questions API" do
  before :each do
    @questions = FactoryGirl.create_list(:question, 5)
    get '/api/v1/questions'
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

  it 'has a translations attribute' do
    @json.first.should have_key('translations')
    @json.first['translations'].should be_a Array
  end

  it "has a question_identifier" do
    @json.first.should have_key('question_identifier')
    @json.first['question_identifier'].should == @questions.first.question_identifier
  end
end

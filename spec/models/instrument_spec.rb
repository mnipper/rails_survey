# == Schema Information
#
# Table name: instruments
#
#  id                      :integer          not null, primary key
#  title                   :string(255)
#  created_at              :datetime
#  updated_at              :datetime
#  language                :string(255)
#  alignment               :string(255)
#  child_update_count      :integer          default(0)
#  previous_question_count :integer
#  project_id              :integer
#  published               :boolean
#  deleted_at              :datetime
#  show_instructions       :boolean          default(FALSE)
#

require "spec_helper"

describe Instrument do
  it { should respond_to(:questions) }
  it { should respond_to(:surveys) }
  it { should respond_to(:current_version_number) }

  before :each do
    @instrument = create(:instrument)
  end

  describe "versioning", versioning: true do
    it "should return the correct version number" do
      @instrument.current_version_number.should == 0
      @instrument.update_attributes(title: 'New text')
      @instrument.current_version_number.should == 1
    end

    it "should be version 0 at first" do
      @instrument.current_version_number.should == 0
    end

    it "should create a new version when adding questions and options" do
      questions = create_list(:question, 10, instrument: @instrument)
      create_list(:option, 5, question: questions.first)
      @instrument.current_version_number.should == 15 
    end

    it "should create a new version if a question is updated" do
      @instrument.current_version_number.should == 0
      question = create(:question, instrument: @instrument)
      @instrument.current_version_number.should == 1
      question.update_attributes(text: 'New text')
      @instrument.current_version_number.should == 2
    end

    it "should create a new version if a question is created" do
      @instrument.current_version_number.should == 0
      question = create(:question, instrument: @instrument)
      @instrument.current_version_number.should == 1
    end

    it "should return the correct title for the new version" do
      @instrument.update_attributes(title: 'New title')
      @instrument.version_by_version_number(1).title = 'New title'
    end

    it "should return the correct question text for the old version" do
      question = create(:question, instrument: @instrument)
      old_text = question.text
      question.update_attributes(text: 'New text')
      @instrument.version_by_version_number(1).questions.first.text.should == old_text
      @instrument.version_by_version_number(2).questions.first.text.should == 'New text'
    end

    it "should return the correct option for the instrument version" do
      question = create(:question, instrument: @instrument)
      option = create(:option, question: question)
      @instrument.version_by_version_number(1).questions.first.options.should == []
      @instrument.version_by_version_number(2).questions.first.options.should == [option]
    end
  end

  describe "alignment" do
    it "should set alignment to right for right-aligned languages" do
      @instrument.update_attributes!(language: Settings.right_align_languages.first)
      @instrument.alignment.should == "right"
    end

    it "should set alignment to left for left-aligned languages" do
      @instrument.update_attributes!(language: 'en')
      @instrument.alignment.should == "left"
    end
  end

  describe "validations" do
    it "should not allow a blank title" do
      @instrument.title = ""
      @instrument.should_not be_valid
    end

    it "should not allow a nil title" do
      @instrument.title = nil
      @instrument.should_not be_valid
    end

    it "should not allow a blank language" do
      @instrument.language = " "
      @instrument.should_not be_valid
    end

    it "should require lowercase ISO-639-1 language code" do
      invalid_codes = ['EN', 'english', '1e']
      invalid_codes.each do |code|
        @instrument.language = code
        @instrument.should_not be_valid
      end
    end

    it "should be valid for lowercase ISO-639-1 language codes" do
      invalid_codes = ['en', 'sw', 'ar']
      invalid_codes.each do |code|
        @instrument.language = code
        @instrument.should be_valid
      end
    end

    it "should be valid for left and right alignment" do
      @instrument.alignment = 'left'
      @instrument.should be_valid
      @instrument.alignment = 'right'
      @instrument.should be_valid
    end

    it "should be valid" do
      @instrument.should be_valid
    end
  end

  describe "translations" do
    before :each do
      @translation = create(:instrument_translation)
    end

    it "should have a translation" do
      @translation.instrument.has_translation_for?(@translation.language).should be_truthy
    end

    it "should have a translation" do
      @translation.instrument.has_translation_for?('nope').should be_falsey
    end

    it "should return the correct translation" do
      @translation.instrument.translated_for(@translation.language, :title).should == @translation.title
    end
  end

  describe "export" do
    before :each do
      @question = create(:question, instrument: @instrument)
    end

    it "should export correctly" do
      out = []
      @instrument.export(out)
      out.should == [
        ["Instrument id:", @instrument.id],
        ["Instrument title:", @instrument.title],
        ["Version number:", @instrument.current_version_number],
        ["Language:", @instrument.language],
        ["\n"],
        ["number_in_instrument", "question_identifier", 'question_type', 'question_text', 'question_instructions'],
        [@question.number_in_instrument, @question.question_identifier, @question.question_type, @question.text, @question.instructions]
      ]
    end
  end
end

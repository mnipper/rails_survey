# == Schema Information
#
# Table name: instruments
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  language           :string(255)
#  alignment          :string(255)
#  child_update_count :integer
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
      questions = create_list(:question, 10, instrument: @instrument)
      create_list(:option, 5, question: questions.first)
      @instrument.current_version_number.should == 0
    end

    it "should create a new version if a question is updated" do
      @instrument.current_version_number.should == 0
      question = create(:question, instrument: @instrument)
      question.update_attributes(text: 'New text')
      @instrument.current_version_number.should == 1
    end
  end

  describe "alignment" do
    it "should set alignment to right for right-aligned languages" do
      @instrument.update_attributes!(language: Settings.right_align_languages.first)
      @instrument.alignment.should == "right"
    end

    it "should set alignment to left for left-aligned languages" do
      @instrument.update_attributes!(language: (Settings.languages - Settings.right_align_languages).first)
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

    it "should be valid" do
      @instrument.should be_valid
    end
  end
end

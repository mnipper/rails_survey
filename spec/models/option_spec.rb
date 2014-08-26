# == Schema Information
#
# Table name: options
#
#  id                 :integer          not null, primary key
#  question_id        :integer
#  text               :text
#  created_at         :datetime
#  updated_at         :datetime
#  next_question      :string(255)
#  number_in_question :integer
#  deleted_at         :datetime
#

require "spec_helper"

describe Option do
  it { should respond_to(:question) }

  before :each do
    @option = build(:option)
  end

  it "should return the text when to_s" do
    @option.to_s.should == @option.text
  end

  describe "validations" do
    it "should not allow blank text" do
      @option.text = ' ' 
      @option.should_not be_valid
    end
  end

  describe "translations" do
    before :each do
      @translation = create(:option_translation)
    end

    it "should have a translation" do
      @translation.option.has_translation_for?(@translation.language).should be_truthy
    end

    it "should have a translation" do
      @translation.option.has_translation_for?('nope').should be_falsey
    end

    it "should return the correct translation" do
      @translation.option.translated_for(@translation.language, :text).should == @translation.text
    end
  end

  describe "versioning", :versioning => true do
    it "should turn on PaperTrail" do
      PaperTrail.should be_enabled
    end

    it "should have one version" do
      option = create(:option)
      option.text = "edited"
      option.versions.count.should == 1
    end
  end
end

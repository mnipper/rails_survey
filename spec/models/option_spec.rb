# == Schema Information
#
# Table name: options
#
#  id            :integer          not null, primary key
#  question_id   :integer
#  text          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  next_question :string(255)
#

require "spec_helper"

describe Option do
  it { should respond_to(:question) }

  it "should return the text when to_s" do
    option = build(:option)
    option.to_s.should == option.text
  end

  describe "translations" do
    before :each do
      @translation = create(:option_translation)
    end

    it "should have a translation" do
      @translation.option.has_translation_for?(@translation.language).should be_true
    end

    it "should have a translation" do
      @translation.option.has_translation_for?('nope').should be_false
    end

    it "should return the correct translation" do
      @translation.option.translated_for(@translation.language, :text).should == @translation.text
    end
  end
end

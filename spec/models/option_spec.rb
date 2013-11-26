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
end

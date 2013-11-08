require "spec_helper"

describe Option do
  it { should respond_to(:question) }

  it "should return the text when to_s" do
    option = build(:option)
    option.to_s.should == option.text
  end
end

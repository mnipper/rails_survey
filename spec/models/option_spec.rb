require "spec_helper"

describe Option do
  it "should return the text when to_s" do
    option = Option.create(text: 'a')
    option.to_s.should == 'a'
  end
end

require "spec_helper"

describe Device do
  it { should respond_to(:surveys) }
  it { should respond_to(:danger_zone?) }
  it { should respond_to(:last_survey) }

  describe "danger zone" do
    
    before :each do
      @device = Device.new
      @survey = Survey.new
      @device.stub(:last_survey).and_return(@survey)
    end

    it "should be in the danger zone if last survey is too old" do
      @survey.stub(:updated_at).and_return(1.day.ago)
      @device.danger_zone?.should be_true
    end

    it "should not be in the danger zone if last survey is new" do
      @survey.stub(:updated_at).and_return(1.minute.ago)
      @device.danger_zone?.should be_false
    end
  end

  it "should not allow duplicate identifiers" do
    device1 = Device.create(identifier: 'a')
    device2 = Device.new(identifier: 'a')
    device2.should_not be_valid
    device1.destroy
  end
end

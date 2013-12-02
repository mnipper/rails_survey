# == Schema Information
#
# Table name: instruments
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  language   :string(255)
#  alignment  :string(255)
#

require "spec_helper"

describe Instrument do
  it { should respond_to(:questions) }
  it { should respond_to(:surveys) }
  it { should respond_to(:current_version_number) }

  describe "versioning" do
    before :each do
      @instrument = create(:instrument)
    end

    it "should return the correct version number" do
      @instrument.current_version_number.should == 0
    end
  end
end

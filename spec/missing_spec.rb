require 'spec_helper'

describe Extended::Missing do

  context "displaying as a string" do
    it "displays as '-'" do
      subject.to_s.should == "-"
    end
  end

  context "asking for the value" do
    it "returns nil" do
      subject.value.should be_nil
    end
  end

end

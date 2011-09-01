require 'spec_helper'

module Extended
  describe DateTime do
    
    let(:datetime){ Extended::DateTime.new("2011-09-01 11:23:00") }
    let(:expected_time){ Time.utc(2011,9,1,11,23) }

    context "to_s" do
      it "displays a formatted timestamp" do
        datetime.to_s.should == "01 Sep 2011 11:23"
      end
    end

    context "time conversions" do
      it "converts to a Time" do
        datetime.to_time.should be_a_kind_of(::Time)
        datetime.to_time.should == expected_time
      end

      it "converts to a DateTime" do
        datetime.to_datetime.should be_a_kind_of(::DateTime)
      end

      it "converts to the integer representation of the time" do
        datetime.to_i.should == expected_time.to_i
      end

      it "converts to the float representation of the time" do
        datetime.to_f.should == expected_time.to_f
      end
    end

  end
end

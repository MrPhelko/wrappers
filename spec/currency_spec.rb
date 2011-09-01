require 'spec_helper'

module Extended
  describe Currency do

    let(:gbp){ Extended::Currency.new("GBp") }
    let(:usd){ Extended::Currency.new("USD") }

    context "when converting to a string" do
      it "upcases lowercase currency symbols" do
        gbp.to_s.should == "GBP"
      end

      it "doesnt alter uppercase currency symbols" do
        usd.to_s.should == "USD"
      end
    end

  end

end

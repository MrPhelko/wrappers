require 'spec_helper'

describe Extended::Number, 'summing values' do
  it 'returns the number if a blank added to a number' do
    value = Extended::Number.new(10) + Extended::Blank.new
    value.should == Extended::Number.new(10)
  end

  it 'returns the number if a number added to a blank' do
    value = Extended::Blank.new + Extended::Number.new(10)
    value.should == Extended::Number.new(10)
  end
end

describe Extended::Money, 'summing values' do
  it 'returns blank if summed with a blank' do
    value = Extended::Money.new(100) + Extended::Blank.new
    value.should == Extended::Blank.new
  end
end
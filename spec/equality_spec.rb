require 'spec_helper'

describe Extended::Number, :equality do
  it 'matches a matching numeric value' do
    (Extended::Number.new(100) == 100).should be_true
  end
  
  it 'does not match a non matching numeric value' do
    (Extended::Number.new(100) == 1).should be_false
  end
  
  it 'can handle less than' do
    (Extended::Number.new(100) < 110).should be_true
  end
end

describe Extended::Money, :equality do
  it 'does not raise an erro when attempting to match a number' do
    expect { Extended::Money.new(100) == 100 }.to_not raise_error
  end
end
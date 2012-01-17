require 'spec_helper'

describe Extended::Number, :to_yaml do
  it 'outputs the big decimal with decimals' do
    Extended::Number.new(100).to_yaml.should == '100.0'
    Extended::Number.new(100.12).to_yaml.should == '100.12'
    Extended::Number.new(10000).to_yaml.should == '10000.0'
  end
end
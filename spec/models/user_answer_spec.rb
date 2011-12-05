require File.dirname(__FILE__) + '/../spec_helper'

describe UserAnswer do
  it "should be valid" do
    UserAnswer.new.should be_valid
  end
end

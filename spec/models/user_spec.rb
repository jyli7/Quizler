require 'spec_helper'

describe User do

  before(:each) do
    @attr = { :email => "user@example.com", :password => "fakepass" }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "should require a password" do 
    no_password_user = User.new(@attr.merge(:password => ""))
    no_password_user.should_not be_valid
  end
end
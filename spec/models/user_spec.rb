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
  
  it "should reject names that are too long" do 
    long_email = "a" * 51 + "@gmail.com"
    long_email_user = User.new(@attr.merge(:email => long_email))
    long_email_user.should_not be_valid
  end
  
  it "should reject invalid email addresses" do 
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
end
require 'spec_helper'

describe Question do

  before(:each) do
    @attr = { :question => "What's my name?", :answer => "foobar", :num => "24" }
  end

  it "should create a new instance given valid attributes" do
    Question.create!(@attr)
  end
  
  it "should require a question" do 
    no_question_question = User.new(@attr.merge(:question => ""))
    no_question_question.should_not be_valid
  end
  
  it "should require an answer" do 
    no_answer_question = User.new(@attr.merge(:answer => ""))
    no_answer_question.should_not be_valid
  end
  
  it "should require a num" do 
    no_num_question = User.new(@attr.merge(:num => ""))
    no_num_question.should_not be_valid
  end  
end
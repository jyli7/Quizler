class Question
  include MongoMapper::Document
  
  key :question, String, :required => true
  key :answer, String, :required => true
  key :num, Integer, :required => true
end

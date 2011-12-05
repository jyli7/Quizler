class UserAnswer
  include MongoMapper::Document
  
  key :answer, String, :required => true
  belongs_to :question
  belongs_to :user
end
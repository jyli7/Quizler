class User
  include MongoMapper::Document
  
  key :email, String
  key :password, String, :required => true
end

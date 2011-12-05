class User
  include MongoMapper::Document
  
  key :email, String
  key :password, String, :required => true
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, :length => {:maximum => 50},
                    :format => { :with => email_regex }
end

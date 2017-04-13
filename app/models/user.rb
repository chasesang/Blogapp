class User < ApplicationRecord
  attr_accessor :current_password
  
  has_secure_password
    has_many :posts
    has_many :comments

    validates(:first_name, { presence: true })
      validates(:last_name, { presence: true })
      validates(:email, { presence: true, uniqueness: true })

end

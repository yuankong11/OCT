class User < ApplicationRecord
  def self.new_user(username)
    User.create(email: username)
  end
end

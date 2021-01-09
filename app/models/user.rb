class User < ApplicationRecord
  has_many :tasklists, :c_calendars
  def self.new_user(username)
    User.create(email: username)
  end
end

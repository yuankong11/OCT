class User < ApplicationRecord
  has_many :tasklists
  has_many :c_calendars
  has_many :file_records
  def self.new_user(username)
    User.create(email: username)
  end
end

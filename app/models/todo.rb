class Todo < ApplicationRecord
    belongs_to :tasklist
    validates :title, presence: true, length: { minimum: 1, maximum: 500 }
end

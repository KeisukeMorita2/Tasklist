class Task < ApplicationRecord
    validates :status, presence: true, length: { within:1..10 }
    belongs_to :user
end

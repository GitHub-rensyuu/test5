class Message < ApplicationRecord
  validates :message, presence: true, length: { minimum: 1, maximum: 140 }
  belongs_to :user
  belongs_to :room
end

class Group < ApplicationRecord
  validates :name, presence: true
  validates :introduction, presence: true
  attachment :image, destroy: false

  has_many :group_users
  has_many :users, through: :group_users


end

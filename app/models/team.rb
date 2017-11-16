class Team < ApplicationRecord
  belongs_to :user
  has_many :user_teams
  has_many :users, through: :user_teams

  validates :name, length: { in: 3..10 }
  validates :name, uniqueness: true
end

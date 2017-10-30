class Relationship < ApplicationRecord
  belongs_to :friend, class_name: "User"
  belongs_to :befriender, class_name: "User"

  validates :friend_id, uniqueness: { scope: :befriender_id }

end

class Tag < ApplicationRecord
  has_many :forum_tags
  has_many :posts, through: :forum_tags

  def self.search(search)
    where("title iLIKE ?", "%#{search}%")
  end

end

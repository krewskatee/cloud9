class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, touch: :created_at

  validates :content, presence: true
  validates :content, length: { in: 10..500 }

end

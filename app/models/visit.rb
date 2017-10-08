class Visit < ApplicationRecord
  has_many :posts
  has_many :post_visits
end

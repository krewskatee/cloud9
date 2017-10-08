class PostVisit < ApplicationRecord
  belongs_to :visit
  belongs_to :post
end

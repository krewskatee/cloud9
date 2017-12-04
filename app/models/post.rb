class Post < ApplicationRecord
  include PgSearch
  pg_search_scope :search_for, :against => [:content, :title],
  :associated_against => {:tags => [:title]}


  belongs_to :user
  belongs_to :team

  has_many :comments
  has_many :forum_tags
  has_many :tags, through: :forum_tags
  has_many :post_visits
  has_many :visits, through: :post_visits


  has_attached_file :post_image, styles: { large: "600x600>", tiny: "25x25>", thumb: "75x75>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :post_image, content_type: /\Aimage\/.*\z/
  #validates_with AttachmentPresenceValidator, attributes: :post_image

  validates :title, presence: true
  validates :title, length: { in: 3..40 }
  validates :content, length: { in: 10..500 }


  def visit_count
    visits.count
  end

  def tag_collection
    tag_array = []
    tags.each do |tag|
      tag_array << tag.title
    end
    tag_collection = tag_array.join(" ")
  end


end

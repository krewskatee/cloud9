class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :chat_messages
  has_many :comments
  has_many :posts, through: :comments

  has_many :user_chats
  has_many :chats, through: :user_chats

  has_many :friends, class_name: "Relationship", foreign_key: :friend_id
  has_many :befrienders, class_name: "Relationship", foreign_key: :befriender_id

  validates :username, presence: true
  validates :username, length: { in: 3..10 }
  validates :username, uniqueness: true

  has_attached_file :avatar, styles: { large: "600x600>", tiny: "25x25>", thumb: "75x75>" }, default_url: "missing.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  #validates_with AttachmentPresenceValidator, attributes: :post_image


  def accepted_friends
    (friends.where("status = 'accepted'") + befrienders.where("status = 'accepted'")).flatten
  end

  def friend_requests
    friends.where("status = 'pending'")
  end

end

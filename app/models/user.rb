class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :chat_messages
  has_many :comments
  has_many :posts, through: :comments
  has_many :chats

  has_many :friends, class_name: "Relationship", foreign_key: :friend_id
  has_many :befrienders, class_name: "Relationship", foreign_key: :befriender_id

  validates :username, presence: true
  validates :username, length: { in: 3..10 }
  validates :username, uniqueness: true
end

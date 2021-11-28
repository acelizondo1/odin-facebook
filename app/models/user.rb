class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, 
         omniauth_providers: %i[facebook]

  validates :name, presence: true

  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, dependent: :destroy

  has_one_attached :avatar, dependent: :destroy 

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy

  scope :non_friends, ->(user){left_outer_joins(:friendships).where('NOT users.id = ? AND (NOT friendships.friend_id = ? OR friendships.friend_id IS NULL)', user.id, user.id).order('RANDOM()')}
        
  def self.is_friend?(user, friend)
    is_friend = Friendship.where("user_id = ? AND friend_id = ?", user.id, friend.id)
    is_friend.empty? ? false : true
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      file = download_remote_file(auth.info.image)
      user.avatar.attach(io: file, filename: "user_avatar_#{user.id}.jpg", content_type: "image/jpg")
    end
  end
  
  private
  def self.download_remote_file(url)
    response = Net::HTTP.get_response(URI.parse(url))
    response = Net::HTTP.get_response(URI.parse(response['location'])) if response.code == "302"
    StringIO.new(response.body)
  end
end

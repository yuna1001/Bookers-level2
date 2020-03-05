class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy


  has_many :following, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :following_user, through: :following, source: :follower
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :follower_user, through: :follower, source: :following

  def follow(other_user)
    following.create(follower_id: other_user.id)
  end

  # ユーザーをアンフォローする
  def unfollow(other_user)
    following.find_by(follower_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following_user.include?(other_user)
  end

  attachment :profile_image
  validates :name,
    presence: true,
    length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 } 

end

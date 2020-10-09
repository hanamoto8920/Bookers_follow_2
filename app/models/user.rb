class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # フォロー機能関係性
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy  #ユーザー＝フォローする人
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy #ユーザー＝フォローされる人

  # 自分のフォロー関係性
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人

  # フォローメソッド定義
  # ユーザーをフォローする
  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end


  has_many :books, dependent: :destroy

  attachment :profile_image

  validates :name, presence: true
  validates :name, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }



end

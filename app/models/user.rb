class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :contributions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorits, dependent: :destroy
  has_many :follower, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy

  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower

  def active_for_authentication?
    super && (is_deleted == false)
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = 'ゲストユーザー'
    end
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

  def follow(user_id)
 follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
   follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
   following_user.include?(user)
  end

  def self.looks(searches, words)
    if searches == "perfect_match"
      return User.where("nickname LIKE ?", "#{ words }")
    else
      return User.where("nickname LIKE ?", "%#{ words }%")
    end
  end
end

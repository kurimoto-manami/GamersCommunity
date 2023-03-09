class Contribution < ApplicationRecord

  belongs_to :genre
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorits, dependent: :destroy

  def self.search(search)
    if search != ""
      Contribution.where(['title LIKE(?)', "%#{search}%"])
    else
      Contribution.includes(:user).order('created_at DESC')
    end
    render :index
  end

  def favorited_by?(user)
    favorits.exists?(user_id: user.id)
  end
end

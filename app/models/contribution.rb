class Contribution < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorits, dependent: :destroy
  has_many :contribution_tags, dependent: :destroy
  has_many :tags, through: :contribution_tags, dependent: :destroy

  def self.looks(search, word)
    if search == "perfect_match"
      @contribution = Contribution.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @contribution = Contribution.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @contribution = Contribution.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @contribution = Contribution.where("title LIKE?","%#{word}%")
    else
      @contribution = Contribution.all
    end
  end

  def favorited_by?(user)
    favorits.exists?(user_id: user.id)
  end

  def self.looks(searches, words)
    if searches == "perfect_match"
      return Contribution.where("title LIKE ?", "#{ words }")
    else
      return Contribution.where("title LIKE ?", "%#{ words }%")
    end
  end
end

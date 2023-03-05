class Contribution < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :genre
  belongs_to :user
  has_many :comments
  has_many :favorit

  def self.search(search)
    if search != ""
      Contribution.where(['title LIKE(?)', "%#{search}%"])
    else
      Contribution.includes(:user).order('created_at DESC')
    end
    render :index
  end
end

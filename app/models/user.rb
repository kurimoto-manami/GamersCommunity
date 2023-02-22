class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :contributons, dependent: :destroy
  has_many :genres
  belongs_to :follow

  def active_for_authentication?
    super && (is_deleted == false)
  end
end

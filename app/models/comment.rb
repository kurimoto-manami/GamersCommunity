class Comment < ApplicationRecord

  belongs_to :contribution
  belongs_to :user

  validates :substance, presence: true
end

class Tag < ApplicationRecord
  has_many :contribution_tags, dependent: :destroy
  has_many :contributions, through: :contribution_tags
end

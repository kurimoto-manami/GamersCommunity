class ContributionTag < ApplicationRecord
  belongs_to :contribution
  belongs_to :tag
end

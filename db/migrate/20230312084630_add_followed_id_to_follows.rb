class AddFollowedIdToFollows < ActiveRecord::Migration[6.1]
  def up
    add_column :follows, :followed_id, :integer
  end
end

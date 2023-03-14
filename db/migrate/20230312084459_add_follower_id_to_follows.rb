class AddFollowerIdToFollows < ActiveRecord::Migration[6.1]
  def up
    add_column :follows, :follower_id, :integer
  end
end

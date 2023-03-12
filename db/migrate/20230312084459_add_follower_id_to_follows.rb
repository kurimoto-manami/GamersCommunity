class AddFollowerIdToFollows < ActiveRecord::Migration[6.1]
  def change
    add_column :follows, :follower, :string
  end
end

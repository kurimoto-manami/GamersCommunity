class AddFollowedIdToFollows < ActiveRecord::Migration[6.1]
  def change
    add_column :follows, :followed, :string
  end
end

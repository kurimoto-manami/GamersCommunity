class RemoveCommentFromComments < ActiveRecord::Migration[6.1]
  def down
    remove_column :comments, :comment, :text
  end
end

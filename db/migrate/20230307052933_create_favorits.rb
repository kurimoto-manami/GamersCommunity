class CreateFavorits < ActiveRecord::Migration[6.1]
  def change
    create_table :favorits do |t|

      t.timestamps
      t.integer :user_id
      t.integer :contribution_id
    end
  end
end

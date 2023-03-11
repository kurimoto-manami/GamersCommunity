class CreateContributionTags < ActiveRecord::Migration[6.1]
  def change
    create_table :contribution_tags do |t|
      t.references :contribution, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end

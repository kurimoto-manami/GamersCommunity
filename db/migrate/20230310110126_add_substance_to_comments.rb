class AddSubstanceToComments < ActiveRecord::Migration[6.1]
  def up
    add_column :comments, :substance, :text
  end
end

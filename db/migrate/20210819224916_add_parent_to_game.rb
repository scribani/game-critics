class AddParentToGame < ActiveRecord::Migration[6.1]
  def change
    add_reference :games, :parent, foreign_key: { to_table: :games }
  end
end

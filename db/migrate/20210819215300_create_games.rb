class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :name
      t.text :summary
      t.date :release_date
      t.integer :category, default: 0
      t.decimal :rating, default: 0

      t.timestamps
    end
    add_index :games, :name, unique: true
  end
end

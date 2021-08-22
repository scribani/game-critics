class CreateCritics < ActiveRecord::Migration[6.1]
  def change
    create_table :critics do |t|
      t.string :title
      t.text :body
      t.references :user, null: false, foreign_key: true
      t.references :criticable, polymorphic: true, null: false

      t.timestamps
    end
  end
end

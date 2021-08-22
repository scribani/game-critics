class CreateAuthentications < ActiveRecord::Migration[6.1]
  def change
    create_table :authentications do |t|
      t.string :provider
      t.string :uid
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

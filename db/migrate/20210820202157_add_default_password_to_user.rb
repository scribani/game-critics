class AddDefaultPasswordToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :default_password, :string
  end
end

class AddGamesCountToCompany < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :games_count, :integer, default: 0
  end
end

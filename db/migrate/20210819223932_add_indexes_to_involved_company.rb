class AddIndexesToInvolvedCompany < ActiveRecord::Migration[6.1]
  def change
    add_index :involved_companies, [:company_id ,:game_id], unique: true
  end
end

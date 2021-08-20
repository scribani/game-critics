class ChangeNameOfGamesPlaformsJoinTable < ActiveRecord::Migration[6.1]
  def change
    # This will a typo (platfoms -> platforms)
    drop_join_table :games, :platfoms do |t|
      t.index [:game_id, :platfom_id]
      t.index [:platfom_id, :game_id]
    end

    create_join_table :games, :platforms do |t|
      t.index [:game_id, :platform_id]
      t.index [:platform_id, :game_id]
    end
  end
end

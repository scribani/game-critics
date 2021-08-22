class CreateJoinTableGamePlatform < ActiveRecord::Migration[6.1]
  def change
    create_join_table :games, :platfoms do |t|
      t.index [:game_id, :platfom_id]
      t.index [:platfom_id, :game_id]
    end
  end
end

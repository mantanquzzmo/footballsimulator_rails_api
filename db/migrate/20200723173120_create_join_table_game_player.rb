class CreateJoinTableGamePlayer < ActiveRecord::Migration[6.0]
  def change
    create_join_table :games, :players do |t|
      t.index [:player_id, :game_id]
      t.index [:game_id, :player_id]
    end
  end
end

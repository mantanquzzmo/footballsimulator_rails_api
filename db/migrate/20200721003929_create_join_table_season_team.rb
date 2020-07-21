class CreateJoinTableSeasonTeam < ActiveRecord::Migration[6.0]
  def change
    create_join_table :seasons, :teams do |t|
      t.index [:season_id, :team_id]
      t.index [:team_id, :season_id]
    end
  end
end

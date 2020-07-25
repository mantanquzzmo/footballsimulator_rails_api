class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.integer :round, null: false
      t.integer :home_team_id
      t.integer :away_team_id
      t.integer :goals_ht
      t.integer :goals_at
      t.integer :winner_team_id
      t.string :result
      t.belongs_to :season, foreign_key: true
      t.timestamps
    end
  end
end
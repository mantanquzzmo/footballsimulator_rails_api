class CreateSeasons < ActiveRecord::Migration[6.0]
  def change
    create_table :seasons do |t|

      t.string :season_teams, array: true, default: []
      t.belongs_to :teams, foreign_key: true
      t.timestamps
    end
  end
end

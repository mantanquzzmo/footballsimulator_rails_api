class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|

      t.integer :round, null: false
      t.string :outcome 
      t.string :result
      t.string :halftime_result

      t.belongs_to :season, foreign_key: true
      t.timestamps
    end
  end
end
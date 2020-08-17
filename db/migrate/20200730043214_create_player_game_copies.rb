class CreatePlayerGameCopies < ActiveRecord::Migration[6.0]
  def change
    create_table :player_game_copies do |t|
      t.string :name, null: false
      t.integer :age, null: false
      t.string :position, null: false
      t.float :skill, null: false
      t.integer :form, null: false
      t.integer :form_tendency, null: false
      t.boolean :starting_11, null: false
      t.integer :original_player_id
      t.integer :team_id
      t.float :performance
      
      t.belongs_to :game, foreign_key: true
      t.timestamps
    end
  end
end

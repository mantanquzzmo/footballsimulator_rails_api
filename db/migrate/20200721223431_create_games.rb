class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|

      # t.integer :round, null: false
      # t.string :ht_name, null: false, array: true
      # t.string :at_name, null: false, array: true
      # t.integer :ht_id, null: false, array: true
      # t.integer :at_id, null: false, array: true
      # t.string :ht_p_names, null: false, array: true
      # t.string :at_p_names, null: false, array: true
      # t.float :ht_p_skill, null: false, array: true
      # t.float :at_p_skill, null: false, array: true
      # t.boolean :ht_p_start, array: true
      # t.boolean :at_p_start, array: true
      # t.string :outcome 
      # t.string :result
      # t.string :halftime_result
      # t.float :ht_prf, array: true
      # t.float :at_prf, array: true

      t.belongs_to :season, foreign_key: true
      t.timestamps
    end
  end
end
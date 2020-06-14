class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.integer :age, null: false
      t.string :position, null: false
      t.integer :skill, null: false
      t.integer :form, null: false
      t.integer :form_tendency, null: false
      t.integer :team_id



      t.timestamps
    end
  end
end

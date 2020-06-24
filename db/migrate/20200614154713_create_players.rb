class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.integer :age, null: false
      t.string :position, null: false
      t.float :skill, null: false
      t.integer :form, null: false
      t.integer :form_tendency, null: false
      t.belongs_to :team, foreign_key: true

      t.timestamps
    end
  end
end

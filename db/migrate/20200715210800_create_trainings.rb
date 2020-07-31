class CreateTrainings < ActiveRecord::Migration[6.0]
  def change
    create_table :trainings do |t|

      t.integer :form_before, null: false
      t.integer :form_after, null: false
      t.integer :form_tendency_before, null: false
      t.integer :form_tendency_after, null: false
      t.belongs_to :player, foreign_key: true

      t.timestamps
    end
  end
end
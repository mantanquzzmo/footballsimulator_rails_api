class CreateCpuTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :cpu_teams do |t|
      t.string :name
      t.string :primary_color
      t.string :secondary_color, null: true
      t.integer :balance, default: 100

      t.timestamps
    end
  end
end

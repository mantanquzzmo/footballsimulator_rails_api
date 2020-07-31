# frozen_string_literal: true

require 'date'
class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :primary_color
      t.string :secondary_color, null: true
      t.integer :balance, default: 100
      t.belongs_to :user, foreign_key: true
      t.boolean :cpu_team, default: false

      t.timestamps
    end
  end
end

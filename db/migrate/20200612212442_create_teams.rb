# frozen_string_literal: true

require 'date'
class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.string :primary_color, null: false
      t.string :secondary_color, null: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class CreateSeasons < ActiveRecord::Migration[6.0]
  def change
    create_table :seasons do |t|

      t.integer :round, default: 0
      t.integer :total_rounds
      t.boolean :completed, default: 0
      t.string :winner
      t.integer :winner_id
      t.string :top_goalscorer
      t.integer :top_goalscorer_id

      t.timestamps
    end
  end
end

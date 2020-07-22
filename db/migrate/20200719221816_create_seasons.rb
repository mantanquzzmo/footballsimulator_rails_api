# frozen_string_literal: true

class CreateSeasons < ActiveRecord::Migration[6.0]
  def change
    create_table :seasons do |t|

      t.string :winner
      t.integer :winner_id
      t.string :top_goalscorer
      t.integer :top_goalscorer_id

      t.timestamps
    end
  end
end

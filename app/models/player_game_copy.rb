class PlayerGameCopy < ApplicationRecord
  validates_presence_of :name, :age, :position, :skill, :form, :form_tendency, :player_id
  belongs_to :game
end

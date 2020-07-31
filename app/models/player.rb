class Player < ApplicationRecord
  validates_presence_of :name, :age, :position, :skill, :form, :form_tendency
  belongs_to :team
  has_and_belongs_to_many :games
end

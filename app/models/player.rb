class Player < ApplicationRecord
  validates_presence_of :name, :age, :position, :skill, :form, :form_tendency
  belongs_to :team
end

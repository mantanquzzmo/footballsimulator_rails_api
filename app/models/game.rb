class Game < ApplicationRecord
  belongs_to :season
  has_and_belongs_to_many :teams
end

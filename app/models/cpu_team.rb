class CpuTeam < ApplicationRecord
  validates_presence_of :name, :primary_color, :balance

  has_many :players
  has_and_belongs_to_many :seasons
end

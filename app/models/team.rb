class Team < ApplicationRecord
  validates_presence_of :name, :primary_color, :balance

  has_many :players
  belongs_to :user
end

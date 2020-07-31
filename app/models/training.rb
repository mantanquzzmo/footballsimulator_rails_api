class Training < ApplicationRecord
  validates_presence_of :player_id, :form_before, :form_after, :form_tendency_before, :form_tendency_after

  belongs_to :player
end
# frozen_string_literal: true

FactoryBot.define do
  factory :game do
    factory :pre_game do
      round { 1 }
      home_team_id { 11 }
      away_team_id { 12 }
      association :season
    end
    factory :full_game do
      round { 1 }
      home_team_id { 11 }
      away_team_id { 12 }
      goals_ht { 2 }
      goals_at { 1 }
      winner_team_id { 11 }
      result { 1 }
      association :season
    end
  end
end

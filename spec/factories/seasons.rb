FactoryBot.define do
  factory :season do
    season_teams { [1,2,3,4] }
    # association :team
  end
end

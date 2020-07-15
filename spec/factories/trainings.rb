FactoryBot.define do
  factory :training do
    player_id { 'Gremio' }
    form_before { 10 }
    form_after { 13 }
    form_tendency_before { 3 }
    form_tendency_after { 4 }
    association :player
  end
end

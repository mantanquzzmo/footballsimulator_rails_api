FactoryBot.define do
  factory :player do
    name { 'Marquinhos' }
    age { 21 }
    position { 'A' }
    skill { 5 }
    form { 11 }
    form_tendency { 4 }
    starting_11 { 0 }
    association :team
  end
end
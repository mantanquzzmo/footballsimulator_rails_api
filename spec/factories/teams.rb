FactoryBot.define do
  factory :team do
    name { 'Gremio' }
    primary_color { 'teal' }
    secondary_color { 'blue' }
    association :user
  end
end

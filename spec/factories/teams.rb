require 'date'

FactoryBot.define do
  factory :team do
    name { 'Gremio' }
    primary_color { 'teal' }
    secondary_color { 'blue' }
    dob { Date.today }
    association :user
  end
end

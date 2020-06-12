# frozen_string_literal: true

require 'date'
FactoryBot.define do
  factory :team do
    name { 'Gremio' }
    primary_color { 'teal' }
    primary_color { 'blue' }
    dob { Date.today }
  end
end

require 'rails_helper'

RSpec.describe Player, type: :model do
  describe 'Database table' do
  it { is_expected.to have_db_column :name }
  it { is_expected.to have_db_column :age }
  it { is_expected.to have_db_column :position }
  it { is_expected.to have_db_column :skill }
  it { is_expected.to have_db_column :form }
  it { is_expected.to have_db_column :form_tendency }
  it { is_expected.to have_db_column :starting_11 }
    it { is_expected.to have_db_column :original_player_id }
  end


  describe 'Associations' do
    it { is_expected.to belong_to :team }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(FactoryBot.create(:player)).to be_valid
    end
  end
end
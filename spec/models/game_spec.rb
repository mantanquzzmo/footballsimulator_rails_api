require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column :round }
    it { is_expected.to have_db_column :home_team_id }
    it { is_expected.to have_db_column :away_team_id }
    it { is_expected.to have_db_column :goals_ht }
    it { is_expected.to have_db_column :goals_at }
    it { is_expected.to have_db_column :winner_team_id }
    it { is_expected.to have_db_column :result }
  end
  
  describe 'Associations' do
    it { is_expected.to belong_to :season }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(FactoryBot.create(:pre_game)).to be_valid
      expect(FactoryBot.create(:full_game)).to be_valid
    end
  end
end


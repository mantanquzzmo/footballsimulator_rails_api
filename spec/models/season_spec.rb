require 'rails_helper'

RSpec.describe Season, type: :model do

  describe 'Database table' do
    it { is_expected.to have_db_column :season_teams }
  end

  describe 'Associations' do
    it { is_expected.to have_and_belong_to_many :teams }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:season)).to be_valid
    end
  end
end

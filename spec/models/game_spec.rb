require 'rails_helper'

RSpec.describe Game, type: :model do
  # describe 'Database table' do
  #   it { is_expected.to have_db_column :hometeam }
  #   it { is_expected.to have_db_column :awayteam }
  #   it { is_expected.to have_db_column :hometeam_ids }
  #   it { is_expected.to have_db_column :awayteam_ids }
  #   it { is_expected.to have_db_column :hometeam_names }
  #   it { is_expected.to have_db_column :awayteam_names }
  #   it { is_expected.to have_db_column :hometeam_skill }
  #   it { is_expected.to have_db_column :awayteam_skill }
  #   it { is_expected.to have_db_column :round }
  #   it { is_expected.to have_db_column :result }
  #   it { is_expected.to have_db_column :ht_result }
  #   it { is_expected.to have_db_column :hometeam_prf }
  #   it { is_expected.to have_db_column :awayteam_prf }
  #   end
  
  describe 'Associations' do
    it { is_expected.to belong_to :season }
  end

  # describe 'Factory' do
  #   it 'should have valid Factory' do
  #     expect(FactoryBot.create(:pre_game)).to be_valid
  #     expect(FactoryBot.create(:full_game)).to be_valid
  #   end
  # end
end

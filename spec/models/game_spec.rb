require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column :ht_name }
    it { is_expected.to have_db_column :at_name }
    it { is_expected.to have_db_column :ht_id }
    it { is_expected.to have_db_column :at_id }
    it { is_expected.to have_db_column :ht_p_names }
    it { is_expected.to have_db_column :at_p_names }
    it { is_expected.to have_db_column :ht_p_start }
    it { is_expected.to have_db_column :at_p_start }
    it { is_expected.to have_db_column :ht_p_skill }
    it { is_expected.to have_db_column :at_p_skill }
    it { is_expected.to have_db_column :round }
    it { is_expected.to have_db_column :outcome }
    it { is_expected.to have_db_column :result }
    it { is_expected.to have_db_column :halftime_result }
    it { is_expected.to have_db_column :ht_prf }
    it { is_expected.to have_db_column :at_prf }
    end
  
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

require 'rails_helper'

RSpec.describe Training, type: :model do
  describe 'Database table' do
  it { is_expected.to have_db_column :player_id }
  it { is_expected.to have_db_column :form_before }
  it { is_expected.to have_db_column :form_after }
  it { is_expected.to have_db_column :form_tendency_before }
  it { is_expected.to have_db_column :form_tendency_after }
  end


  describe 'Associations' do
    it { is_expected.to belong_to :player }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(FactoryBot.create(:training)).to be_valid
    end
  end
end
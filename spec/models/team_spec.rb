RSpec.describe Team, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column :name }
    it { is_expected.to have_db_column :primary_color }
    it { is_expected.to have_db_column :secondary_color }
    it { is_expected.to have_db_column :dob }
  end

  describe 'Associations' do
    it { is_expected.to have_many :players }
    it { is_expected.to belong_to :user }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(FactoryBot.create(:player)).to be_valid
    end
  end
end

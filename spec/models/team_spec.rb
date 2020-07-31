RSpec.describe Team, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column :name }
    it { is_expected.to have_db_column :primary_color }
    it { is_expected.to have_db_column :secondary_color }
  end

  describe 'Associations' do
    it { is_expected.to have_many :players }
    it { is_expected.to belong_to :user }
    it { is_expected.to have_and_belong_to_many :seasons }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:team)).to be_valid
    end
  end
end

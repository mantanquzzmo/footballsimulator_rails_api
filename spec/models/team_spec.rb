RSpec.describe Team, type: :model do
  it { is_expected.to have_db_column :name }
  it { is_expected.to have_db_column :primary_color }
  it { is_expected.to have_db_column :secondary_color }
  it { is_expected.to have_db_column :dob }
end

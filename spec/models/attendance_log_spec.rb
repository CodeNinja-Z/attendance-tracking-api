require 'rails_helper'

RSpec.describe AttendanceLog, type: :model do

  # == Relationships ========================================================

  context 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:clock_in_log) }
    it { should have_one(:clock_out_log) }
  end

  # == Validations ==========================================================

  context 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:occured_at) }
    it { should validate_presence_of(:name) }
    it { should validate_inclusion_of(:name).in_array(['ClockIn', 'ClockOut']) }
  end

  # == FactoryBot ===========================================================

  context 'can be created' do
    it 'with FactoryBot' do
      expect(create(:clock_in_log)).to be_valid
    end

    it 'with FactoryBot' do
      expect(create(:clock_out_log)).to be_valid
    end
  end
end

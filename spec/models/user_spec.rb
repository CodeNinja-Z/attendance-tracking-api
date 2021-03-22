require "rails_helper"

RSpec.describe User, type: :model do

  # == Relationships ========================================================

  context 'relationships' do
    it { should have_many(:attendance_logs) }
  end

  # == Validations ==========================================================

  context 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }

    it { should have_secure_password }

    it { should validate_uniqueness_of(:email) }

    it { should validate_length_of(:email).is_at_least(2) }
    it { should validate_length_of(:email).is_at_most(254) }
    it { should validate_length_of(:first_name).is_at_least(2) }
    it { should validate_length_of(:first_name).is_at_most(40) }
    it { should validate_length_of(:last_name).is_at_least(2) }
    it { should validate_length_of(:last_name).is_at_most(40) }
    it { should validate_length_of(:password).is_at_least(4) }
  end

  # == FactoryBot ===========================================================

  context 'can be created' do
    it 'with FactoryBot' do
      expect(create(:user)).to be_valid
    end
  end

  # == Instance Methods =====================================================

  context 'instance methods' do
    describe 'attendance_logs_by_date' do
      let(:user) { create(:user, :with_attendance_logs) }
      let(:user_attendance_logs) { user.attendance_logs }

      it "returns the correct hash" do
        attendance_logs = user.attendance_logs_by_date

        first_key = user_attendance_logs.first.occured_at.strftime("%F")
        second_key = user_attendance_logs.second.occured_at.strftime("%F")

        expect(attendance_logs).to have_key(first_key)
        expect(attendance_logs).to have_key(second_key)
        expect(attendance_logs[first_key].as_json).to match(user_attendance_logs.as_json)
      end
    end

    describe 'durations_of_work_by_date' do
      let(:user) { create(:user, :with_attendance_logs) }
      let(:user_attendance_logs) { user.attendance_logs }

      it "returns the correct hash" do
        durations_of_work = user.durations_of_work_by_date

        first_key = user_attendance_logs.first.occured_at.strftime("%F")
        second_key = user_attendance_logs.second.occured_at.strftime("%F")

        clock_in_time = user_attendance_logs.first.occured_at
        clock_out_time = user_attendance_logs.second.occured_at
        time_diff = clock_out_time - clock_in_time
        formatted_time_diff = ActiveSupport::Duration.build(time_diff).in_hours.round(2).inspect

        expect(durations_of_work).to have_key(first_key)
        expect(durations_of_work).to have_key(second_key)
        expect(durations_of_work[first_key]).to eq(formatted_time_diff)
      end
    end
  end
end

require "rails_helper"

RSpec.describe Api::V1::AttendanceLogsController, type: :controller do

  # == Routes ===============================================================

  context 'routes' do
    it { should route(:get, '/api/v1/attendance_logs').to(action: :index) }
    it { should route(:post, '/api/v1/attendance_logs').to(action: :create) }
    it { should route(:put, '/api/v1/attendance_logs/1').to(action: :update, id: 1) }
    it { should route(:delete, '/api/v1/attendance_logs/1').to(action: :destroy, id: 1) }
  end
end

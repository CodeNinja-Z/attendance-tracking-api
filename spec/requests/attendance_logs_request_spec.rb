require 'rails_helper'

RSpec.describe "AttendanceLogs", type: :request do
  let(:user) { create(:user, :with_attendance_logs) }
  let(:headers) { { 'Authorization' => token_generator(user.id) } }
  let(:invalid_headers) { { 'Authorization' => nil } }

  # == Endpoints ============================================================

  # == index ================================================================

  describe "index | get /api/v1/attendance_logs" do
    context 'when auth token is passed' do
      before { get '/api/v1/attendance_logs', headers: headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end

      it 'returns attendance logs by date to a user' do
        expect(json).to eq(
          { 
            attendance_logs_by_date: user.attendance_logs_by_date,
            durations_of_work_by_date: user.durations_of_work_by_date
          }.as_json
        )
      end
    end

    context 'when auth token is not passed' do
      before { get '/api/v1/attendance_logs', headers: invalid_headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  # == create ===============================================================

  describe "create | post /api/v1/attendance_logs" do
    let(:valid_attributes) { user.attendance_logs.first.as_json }

    context 'when auth token is passed' do
      before do
        post "/api/v1/attendance_logs", params: valid_attributes, headers: headers
      end 
      
      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
      
      it "returns the attendance log created" do
        expect(json).to have_key("attendance_logs_by_date")
        expect(json).to have_key("durations_of_work_by_date")
      end
    end

    context 'when auth token is not passed' do
      before do
        post "/api/v1/attendance_logs", params: valid_attributes, headers: invalid_headers
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  # == update ===============================================================

  describe "update | put /api/v1/attendance_logs/:id" do
    let(:attendance_log) { user.attendance_logs.first }

    context 'when auth token is passed' do
      before do
        attendance_log.occured_at = attendance_log.occured_at - 1.hour
        attendance_log.description = 'clock in'
        put "/api/v1/attendance_logs/#{attendance_log.id}", params: attendance_log.as_json, headers: headers
      end 
      
      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
      
      it "returns the attendance log updated" do
        expect(json).to have_key("attendance_logs_by_date")
        expect(json).to have_key("durations_of_work_by_date")
      end
    end

    context 'when auth token is not passed' do
      before do
        put "/api/v1/attendance_logs/#{attendance_log.id}", params: attendance_log.as_json, headers: invalid_headers
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  # == destroy ==============================================================

  describe "destroy | delete /api/v1/attendance_logs/:id" do
    let(:attendance_log) { user.attendance_logs.first }

    context 'when auth token is passed' do
      before do
        delete "/api/v1/attendance_logs/#{attendance_log.id}", headers: headers
      end 
      
      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
      
      it "returns the updated durations of work" do
        expect(user.attendance_logs.size).to eq(1)
        expect(json).to have_key("durations_of_work_by_date")
      end
    end

    context 'when auth token is not passed' do
      before do
        delete "/api/v1/attendance_logs/#{attendance_log.id}", headers: invalid_headers
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end

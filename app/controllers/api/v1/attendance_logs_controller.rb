class Api::V1::AttendanceLogsController < ApplicationController
  before_action :set_attendance_log, only: [:update, :destroy]

  def index
    json_response(response_payload)
  end

  def create
    if current_user.attendance_logs.exists?
      last_log = current_user.attendance_logs.last
      
      if last_log.name != attendance_log_params[:name]
        new_log = AttendanceLog.new

        new_log.user_id = current_user.id
        new_log.occured_at = Time.now
        new_log.name = attendance_log_params[:name]
        new_log.description = attendance_log_params[:description]

        if last_log.name == "ClockIn" # to create a clock out log
          new_log.clock_in_log_id = last_log.id
        end
        
        new_log.save

        json_response(response_payload, :created)
      else
        json_response(
          { error: "Can't clock in or clock out twice a row!" }, 
          :forbidden
        )
      end
    else # for create 1st log
      if attendance_log_params[:name] == "ClockIn"
        new_log = AttendanceLog.new
        new_log.user_id = current_user.id
        new_log.occured_at = Time.now
        new_log.name = "ClockIn"
        new_log.description = attendance_log_params[:description]
        new_log.save

        json_response(response_payload, :created)
      else
        json_response({ error: "You must clock in first!" }, :forbidden)        
      end
    end
  end

  def update
    if @attendance_log
      @attendance_log.update(attendance_log_params)

      json_response(response_payload)
    end
  end

  def destroy
    if @attendance_log
      @attendance_log.destroy

      json_response(response_payload)
    end
  end

  private

  def response_payload
    {
      attendance_logs_by_date: current_user.attendance_logs_by_date,
      durations_of_work_by_date: current_user.durations_of_work_by_date
    }.as_json    
  end

  def attendance_log_params
    params.permit(
      :user_id, 
      :name, 
      :occured_at, 
      :description, 
      :clock_in_log_id
    )
  end

  def set_attendance_log
    @attendance_log = AttendanceLog.find(params[:id])
  end
end

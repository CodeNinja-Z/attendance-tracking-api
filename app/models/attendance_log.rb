class AttendanceLog < ApplicationRecord

  # == Relationships ========================================================

  belongs_to :user

  belongs_to :clock_in_log, 
    class_name: "AttendanceLog", 
    required: false

  has_one :clock_out_log, 
    class_name: "AttendanceLog", 
    foreign_key: :clock_in_log_id

  # == Validations ==========================================================
  
  validates :name, 
    presence: true,
    inclusion: { in: %w(ClockIn ClockOut),
      message: "%{value} is not a valid clock event name" }

  validates_presence_of :user_id
  validates_presence_of :occured_at
end

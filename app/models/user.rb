class User < ApplicationRecord

  # == Extensions ===========================================================

  has_secure_password
  
  # == Relationships ========================================================

  has_many :attendance_logs

  # == Validations ==========================================================

  validates :first_name, 
    presence: true,
    length: {minimum: 2, maximum: 40}

  validates :last_name, 
    presence: true,
    length: {minimum: 2, maximum: 40}

  validates :email, 
    email: true,
    uniqueness: true,
    length: { minimum: 2, maximum: 254 },
    presence: true

  validates :password, 
    confirmation: true,
    length: {minimum: 4}

  validates_presence_of :password_confirmation
  validates_presence_of :password_digest

  # == Instance Methods =====================================================
  
  def attendance_logs_by_date
    attendance_logs.group_by { |al| al.occured_at.strftime("%F") }
  end

  def durations_of_work_by_date
    all_durations_by_date = {}

    # self-join to avoid N + 1 queries in the reduce method below
    logs_by_date = attendance_logs.includes(:clock_in_log)
      .group_by { |al| al.occured_at.strftime("%F") }

    logs_by_date.keys.each do |key|
      # total time (by date) worked in seconds
      duration_by_date = logs_by_date[key]
        .select { |al| 
          al.name == 'ClockOut' 
        }
        .reduce(0.0) { |sum, al| 
          if al.clock_in_log # make sure the associated clock_in_log exists
            sum += al.occured_at - al.clock_in_log.occured_at 
          else
            sum += 0.0
          end
        }

      # total time (by date) in natual language format
      formatted_duration = ActiveSupport::Duration.build(duration_by_date).in_hours.round(2).inspect
      all_durations_by_date[key] = formatted_duration
    end

    all_durations_by_date
  end
end

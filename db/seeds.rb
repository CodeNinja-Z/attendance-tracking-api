# ==  create 3 users ========================================================

password = '123123'

User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: 'test1@gmail.com',
  password: password,
  password_confirmation: password
)

User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: 'test2@gmail.com',
  password: password,
  password_confirmation: password
)

User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: 'test3@gmail.com',
  password: password,
  password_confirmation: password
)

# == create attendance_logs for 1st user ====================================

first_user = User.find(1)

# logs for Mar 19th

first_user_fourth_clock_in = AttendanceLog.create(
  user_id: first_user.id,
  name: 'ClockIn',
  occured_at: DateTime.new(2021, 03, 20, 8, 30, 0, "EDT"),
  description: 'arrived at work'
)

AttendanceLog.create(
  user_id: first_user.id,
  name: 'ClockOut',
  occured_at: DateTime.new(2021, 03, 20, 12, 0, 0, "EDT"),
  description: 'for lunch',
  clock_in_log_id: first_user_fourth_clock_in.id
)

first_user_fifth_clock_in = AttendanceLog.create(
  user_id: first_user.id,
  name: 'ClockIn',
  occured_at: DateTime.new(2021, 03, 20, 12, 30, 0, "EDT")
)

AttendanceLog.create(
  user_id: first_user.id,
  name: 'ClockOut',
  occured_at: DateTime.new(2021, 03, 20, 17, 0, 0, "EDT"),
  description: "doctor's appointment",
  clock_in_log_id: first_user_fifth_clock_in.id
)

# logs for Mar 22nd

first_user_first_clock_in = AttendanceLog.create(
  user_id: first_user.id,
  name: 'ClockIn',
  occured_at: DateTime.new(2021, 03, 21, 8, 30, 0, "EDT"),
  description: 'arrived at work'
)

AttendanceLog.create(
  user_id: first_user.id,
  name: 'ClockOut',
  occured_at: DateTime.new(2021, 03, 21, 12, 0, 0, "EDT"),
  description: 'for lunch',
  clock_in_log_id: first_user_first_clock_in.id
)

first_user_second_clock_in = AttendanceLog.create(
  user_id: first_user.id,
  name: 'ClockIn',
  occured_at: DateTime.new(2021, 03, 21, 12, 30, 0, "EDT")
)

AttendanceLog.create(
  user_id: first_user.id,
  name: 'ClockOut',
  occured_at: DateTime.new(2021, 03, 21, 15, 0, 0, "EDT"),
  description: "doctor's appointment",
  clock_in_log_id: first_user_second_clock_in.id
)

first_user_third_clock_in = AttendanceLog.create(
  user_id: first_user.id,
  name: 'ClockIn',
  occured_at: DateTime.new(2021, 03, 21, 16, 0, 0, "EDT"),
  description: 'back to work'
)

AttendanceLog.create(
  user_id: first_user.id,
  name: 'ClockOut',
  occured_at: DateTime.new(2021, 03, 21, 17, 0, 0, "EDT"),
  clock_in_log_id: first_user_third_clock_in.id
)

# == create attendance_logs for 2nd user ====================================

second_user = User.find(2)

# logs for Mar 22nd

second_user_first_clock_in = AttendanceLog.create(
  user_id: second_user.id,
  name: 'ClockIn',
  occured_at: DateTime.new(2021, 03, 21, 8, 30, 0, "EDT"),
  description: 'clock in'
)

AttendanceLog.create(
  user_id: second_user.id,
  name: 'ClockOut',
  occured_at: DateTime.new(2021, 03, 21, 12, 0, 0, "EDT"),
  description: 'for lunch',
  clock_in_log_id: second_user_first_clock_in.id
)

second_user_second_clock_in = AttendanceLog.create(
  user_id: second_user.id,
  name: 'ClockIn',
  occured_at: DateTime.new(2021, 03, 21, 12, 30, 0, "EDT"),
  description: 'finished lunch'
)

AttendanceLog.create(
  user_id: second_user.id,
  name: 'ClockOut',
  occured_at: DateTime.new(2021, 03, 21, 17, 0, 0, "EDT"),
  description: 'done for today',
  clock_in_log_id: second_user_second_clock_in.id
)

# == create attendance_logs for 3rd user ====================================

third_user = User.find(3)

# logs for Mar 22nd

third_user_first_clock_in = AttendanceLog.create(
  user_id: third_user.id,
  name: 'ClockIn',
  occured_at: DateTime.new(2021, 03, 21, 8, 30, 0, "EDT"),
  description: 'started working'
)

AttendanceLog.create(
  user_id: third_user.id,
  name: 'ClockOut',
  occured_at: DateTime.new(2021, 03, 21, 17, 0, 0, "EDT"),
  description: 'finished working',
  clock_in_log_id: third_user_first_clock_in.id
)

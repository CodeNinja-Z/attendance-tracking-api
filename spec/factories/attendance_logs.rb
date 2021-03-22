FactoryBot.define do
  factory :clock_in_log, class: 'AttendanceLog' do
    user
    clock_in_log_id { "" }
    name { "ClockIn" }
    occured_at { "2021-03-22 09:00:00" }
    description { Faker::Lorem.sentence }
  end

  factory :clock_out_log, class: 'AttendanceLog' do
    user
    association :clock_in_log, factory: :clock_in_log
    name { "ClockOut" }
    occured_at { "2021-03-22 12:00:00" }
    description { Faker::Lorem.sentence }
  end
end

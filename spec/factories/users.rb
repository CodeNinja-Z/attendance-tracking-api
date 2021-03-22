FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { '123123' }
    password_confirmation { '123123' }

    trait :with_attendance_logs do
      after(:create) do |user|
        clock_in_log = create(:clock_in_log)
        clock_out_log = create(:clock_out_log)
        user.attendance_logs << clock_in_log
        user.attendance_logs << clock_out_log
      end
    end
  end
end

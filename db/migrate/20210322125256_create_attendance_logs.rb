class CreateAttendanceLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :attendance_logs do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.bigint :clock_in_log_id, foreign_key: true
      t.string :name, null: false
      t.datetime :occured_at, null: false
      t.text :description
      t.index :clock_in_log_id

      t.timestamps
    end
  end
end

class CreateOneTimePasswords < ActiveRecord::Migration[5.1]
  def change
    create_table :one_time_passwords do |t|
      t.references :user, index: true
      t.string :encrypted_otp, null: false
      t.timestamp :expired_at
      t.timestamp :verified_at

      t.timestamps
    end
  end
end

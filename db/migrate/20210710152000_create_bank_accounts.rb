class CreateBankAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :bank_accounts do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false
      t.string :account_number, null: false
      t.float :amount, null: false, default: 0

      t.timestamps
    end
  end
end

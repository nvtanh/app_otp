class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.references :beneficiary, foreign_key: true
      t.integer :sender_account_id, null: false, index: true
      t.float :amount, null: false

      t.timestamps
    end
  end
end

class CreateBeneficiaries < ActiveRecord::Migration[5.1]
  def change
    create_table :beneficiaries do |t|
      t.references :user, foreign_key: true
      t.references :bank_account, foreign_key: true
      t.string :nick_name

      t.timestamps
    end
  end
end

class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.string :user_id
      t.integer :payment_type
      t.string :email, limit: 254
      t.string :from, limit: 254
      t.string :to, limit: 254
      t.decimal :value
      t.string :transaction_id, limit: 254
      t.decimal :amount
      t.decimal :fee
      t.string :received_currency
      t.decimal :convert_rate
      t.decimal :received_amount
      t.integer :status
      t.text :details
      t.string :phone, limit: 20
      t.string :code, limit: 100
      t.string :from_currency, limit: 20
      t.string :transaction_hash
      t.string :confirm_token

      t.timestamps
    end
    add_index :payments, :user_id
  end
end

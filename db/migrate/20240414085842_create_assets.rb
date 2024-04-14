class CreateAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :assets do |t|
      t.references :user, foreign_key: true
      t.string :currency
      t.decimal :balance
      t.decimal :locked_balance

      t.timestamps
    end
  end
end

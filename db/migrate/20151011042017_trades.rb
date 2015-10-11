class Trades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.date :trade_date
      t.string :merchant_number
      t.string :merchant_name
      t.string :merchant_tel
      t.string :agent_number
      t.string :agent_name
      t.string :terminal_number
      t.integer :biz_count
      t.decimal :amount, precision: 10, scale: 2

      t.integer :status, :default => 0
      t.timestamps
    end
  end
end

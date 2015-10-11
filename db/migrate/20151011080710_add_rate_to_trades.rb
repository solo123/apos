class AddRateToTrades < ActiveRecord::Migration
  def change
    change_table(:trades) do |t|
      t.decimal :rate, precision: 10, scale: 2
    end
  end
end

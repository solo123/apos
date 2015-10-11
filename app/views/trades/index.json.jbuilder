json.array!(@trades) do |trade|
  json.extract! trade, :trade_date, :merchant_number, :agent_number, :terminal_number, :biz_count, :amount, :commission, :actual_amount, :base_commission, :profit
  json.url trade_url(trade, format: :json)
end

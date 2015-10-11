json.array!(@merchants) do |merchant|
  json.extract! merchant, :merchant_number, :merchant_name, :user_id, :status
  json.url merchant_url(merchant, format: :json)
end

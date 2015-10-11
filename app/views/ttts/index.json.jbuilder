json.array!(@ttts) do |ttt|
  json.extract! ttt, :name, :level
  json.url ttt_url(ttt, format: :json)
end

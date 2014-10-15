json.array!(@suggestions) do |suggestion|
  json.extract! suggestion, :id, :suggestion_id, :name, :description, :score
  json.url suggestion_url(suggestion, format: :json)
end

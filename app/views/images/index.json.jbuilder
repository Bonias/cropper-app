json.array!(@images) do |image|
  json.extract! image, :id, :file
  json.url image_url(image, format: :json)
end

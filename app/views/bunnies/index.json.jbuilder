json.array!(@bunnies) do |bunny|
  json.extract! bunny, :id, :name, :age, :color, :breed, :favorite_comic_book
  json.url bunny_url(bunny, format: :json)
end

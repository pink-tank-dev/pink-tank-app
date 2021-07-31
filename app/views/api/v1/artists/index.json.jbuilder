json.set! :artists do
  json.array! @artists.each do |artist|
    json.id     artist.id
    json.name   artist.name
  end
end

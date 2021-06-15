json.set! :artists do
  json.array! @artists.each do |artist|
    json.value  artist.id
    json.text   artist.name
  end
end

json.set! :artists do
  json.array! @artists.each do |artist|
    json.value  artist.id
    json.text   artist.name
    json.about  artist.about
  end
end

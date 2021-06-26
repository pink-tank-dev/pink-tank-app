json.set! :options do
  json.array! @artists.each do |artist|
    json.value  artist.id
    json.text   artist.name
  end
end

json.set! :artists do
  json.array! @artists.each do |artist|
    json.id  artist.id
    json.name   artist.name
    json.about  artist.about
  end
end

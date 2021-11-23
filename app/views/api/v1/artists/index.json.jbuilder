json.set! :artists do
  json.array! @artists.each do |artist|
    json.id     artist.id
    json.name   artist.name
  end
end

json.partial! 'api/v1/partials/metadata', page: page, limit: nil, total: @artists.size

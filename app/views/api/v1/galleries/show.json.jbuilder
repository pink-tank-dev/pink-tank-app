json.set! :series do
  json.array! @series do |series|
    json.id           series.id
    json.title        series.title
    json.artist_id    series.artist_id
    json.artist_name  series.artist.name
    json.set! :artworks do
      json.array! series.artworks.order(:position) do |artwork|
        json.id       artwork.id
        json.title    artwork.title
      end
    end
  end
end

json.partial! 'api/v1/partials/metadata', page: page, limit: limit, total: @total

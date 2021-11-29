json.set! :exhibition do
  if @exhibition
    json.id         @exhibition.id
    json.title      @exhibition.title
    json.start_at   @exhibition.start_at
    json.end_at     @exhibition.end_at
    json.set! :series do
      json.array! @series do |series|
        json.id           series.id
        json.title        series.title
        json.artist_id    series.artist_id
        json.artist_name  series.artist.name
        json.set! :artworks do
          json.array! series.artworks.order(:position) do |artwork|
            json.partial! 'api/v1/partials/artwork', artwork: artwork
          end
        end
      end
    end
  else
    json.nil!
  end
end

json.partial! 'api/v1/partials/metadata', page: page, limit: limit, total: @total

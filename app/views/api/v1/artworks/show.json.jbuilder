json.set! :artwork do
  json.partial! 'api/v1/partials/artwork', artwork: @artwork
  json.set! :series do
    json.id           @artwork.series.id
    json.title        @artwork.series.title
    json.description  @artwork.series.description
  end
  json.set! :artist do
    json.id     @artwork.artist_id
    json.name   @artwork.artist.name
  end
end

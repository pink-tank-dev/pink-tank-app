json.set! :artwork do
  json.partial! 'api/v1/partials/artwork', artwork: @series.artworks.find_by(id: params[:artwork_id])
  json.set! :series do
    json.id     @series.id
    json.title  @series.title
  end
  json.set! :artist do
    json.id     @series.artist_id
    json.name   @series.artist.name
  end
end

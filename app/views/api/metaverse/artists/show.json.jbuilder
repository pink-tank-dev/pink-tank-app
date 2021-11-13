json.id         @artist.id
json.name       @artist.name
json.about      @artist.about
json.statement  @artist.statement
json.set! :series do
  json.id     @artist.series.id
  json.title  @artist.series.title
  json.set! :artworks do
    json.array! @artist.series.artworks.order(position: :asc) do |artwork|
      json.id           artwork.id
      if artwork.file.present?
        json.html         (ApplicationController.render partial: 'api/metaverse/artists/artwork.html.erb', locals: { file: artwork.file }).html_safe
      else
        json.html       json.nil!
      end
      json.title        artwork.title
      json.description  artwork.description
      json.medium       artwork.medium
      json.measurements artwork.measurements
      json.price        humanized_money_with_symbol(artwork.price)
    end
  end
end

json.id         @artist.id
json.name       @artist.name
json.about      @artist.about
json.statement  @artist.statement
json.set! :series do
  json.id     @artist.series.id
  json.title  @artist.series.title
  json.set! :artworks do
    unless @artist.sito?
      json.array! @artist.series.artworks.order(position: :asc) do |artwork|
        json.id           artwork.id
        json.html         artwork.file_html
        json.title        artwork.title
        json.description  artwork.description
        json.medium       artwork.medium
        json.measurements artwork.measurements
        json.price        humanized_money_with_symbol(artwork.price)
      end
    else
      json.nil!
    end
  end
end

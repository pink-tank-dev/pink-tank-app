json.id           artwork.id
json.title        artwork.title
if artwork.file.present?
  json.html (ApplicationController.render partial: 'api/v1/partials/artwork_file', locals: { file: artwork.file }).html_safe
else
  json.html nil
end
json.description  artwork.description
json.medium       artwork.medium
json.price        humanized_money_with_symbol artwork.price

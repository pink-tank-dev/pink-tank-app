json.id             artist.id
json.name           artist.name
json.avatar_url     artist.avatar.present? ? rails_blob_url(artist.avatar) : nil
json.about          artist.about
json.statement      artist.statement
json.instagram      artist.instagram

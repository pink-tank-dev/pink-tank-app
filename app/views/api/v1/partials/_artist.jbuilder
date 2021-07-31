json.id             artist.id
json.name           artist.name
json.avatar_url     artist.avatar.present? ? url_for(artist.avatar) : nil
json.about          artist.about
json.statement      artist.statement
json.instagram      artist.instagram

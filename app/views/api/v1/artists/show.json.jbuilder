json.partial! 'api/v1/partials/artist', artist: @artist

json.set! :posts do
  json.array! @posts.each do |post|
    json.partial! 'api/v1/partials/post', post: post
  end
end

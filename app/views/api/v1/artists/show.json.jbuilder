json.partial! 'api/v1/partials/artist', artist: @artist

json.set! :social_media do
  if @artist.social_media.any?
    json.array! SocialMedium.media.each do |medium|
      medium_sym = medium.first.to_sym

      json.set! medium_sym do
        social_media = @artist.social_media.send(medium_sym)

        if social_media.any?
          json.array! social_media.pluck(:handle)
        else
          json.nil!
        end
      end
    end
  else
    json.nil!
  end
end

json.set! :posts do
  json.array! @posts.each do |post|
    json.partial! 'api/v1/partials/post', post: post
  end
end

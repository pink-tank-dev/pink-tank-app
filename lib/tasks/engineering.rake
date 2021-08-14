namespace :engineering do
  desc "Migrate instagram to social medium"
  task migrate_instagram_to_social_medium: :environment do
    Artist.all.each do |artist|
      if artist.instagram.present?
        soc_med = SocialMedium.new(artist: artist, medium: :instagram, handle: artist.instagram)
        soc_med.save(validate: false)
      end
    end
  end
end

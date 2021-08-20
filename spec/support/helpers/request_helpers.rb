module Helpers
  module RequestHelpers
    def login_user(user)
      params = { email: user.email, password: user.password }
      post login_user_path, params: params
    end

    def login_artist(artist)
      params = { email: artist.email, password: artist.password }
      post login_artist_path, params: params
    end
  end
end

def set_omniauth
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
    provider: "github",
    uid: "905225",
    info: {
      name: "Rubén Moya",
      email: "rmoyarodriguez@gmail.com"
    },
    extra: {
      raw_info: {
        location: "Madrid, España",
        company: nil,
        html_url: "https://github.com/rubenmoya",
        avatar_url: "https://avatars1.githubusercontent.com/u/905225?v=3&s=460"
      }
    }
   })
end

def set_invalid_omniauth
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:github] = :invalid_credentials
end

def log_in_github
  set_omniauth()
  visit "/"
  click_link "Connect with Github"
end

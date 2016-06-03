module OmniauthMacros
  # rubocop:disable Metrics/LineLength, Metrics/MethodLength
  def mock_auth_hash
    config = OmniAuth::AuthHash.new(provider: "github",
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
                                    },
                                    credentials: {
                                      token: "mock_token",
                                      secret: "mock_secret"
                                    })
    OmniAuth.config.mock_auth[:github] = config
  end

  def mock_invalid_hash
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = :invalid_credentials
  end
end

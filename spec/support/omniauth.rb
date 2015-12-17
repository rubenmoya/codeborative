def log_in_github
  mock_auth_hash()
  visit "/"
  click_link "Connect with Github"
end

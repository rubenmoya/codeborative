Rails.application.routes.draw do
  root 'statics#index'

  devise_for :users, path: '/', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'signup'
  }
end

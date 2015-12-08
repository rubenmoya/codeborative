Rails.application.routes.draw do

  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end

    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end

  root 'statics#index'

  get '/skills' => 'skills#index'
  post '/skills/new' => 'skills#create'


  devise_scope :user do
    post '/update_skills' => 'users/registrations#update_skills'
  end

  devise_for :users,
    path: '/',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      sign_up: 'signup',
      edit: 'profile/edit'
    },
    controllers: {
      registrations: 'users/registrations',
      omniauth_callbacks: 'users/omniauth_callbacks'
    }

  get '/profile/:id' => 'users#show', as: :user_profile
end

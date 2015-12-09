Rails.application.routes.draw do

  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end

    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end

  root 'statics#index'

  get '/search(/:skills)' => 'projects#index', as: :search

  get '/tags' => 'tags#index'
  post '/tags/new' => 'tags#create'

  resources :friendships, only: [:create, :update, :destroy]

  resources :projects do
    post '/update_tags' => 'projects#update_tags'
  end

  get '/profile/projects' => 'users#projects', as: :user_projects
  get '/profile/friends' => 'users#friends', as: :user_friends

  devise_for :users,
    path: '/',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      sign_up: 'signup',
      edit: 'profile'
    },
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      omniauth_callbacks: 'users/omniauth_callbacks'
    }
end

RailsSurvey::Application.routes.draw do

  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      namespace :frontend do
        resources :projects do
          resources :instruments, only: [:index, :show] do
            resources :questions do
              resources :options
              resources :images 
            end
          end
          get 'graphs/daily/' => 'graphs#daily'
          get 'graphs/hourly/' => 'graphs#hourly'
          get 'graphs/count/' => 'graphs#count'
        end
      end

      resources :projects do
        resources :instruments, only: [:index, :show]
        resources :questions, only: [:index, :show]
        resources :options, only: [:index, :show]
        resources :images, only:[:index]
        resources :surveys, only: [:create]
        resources :responses, only: [:create]
        resources :response_images, only: [:create]
        resources :sections, only: [:index, :show]
      end
    end
  end

  root to: 'projects#index'
  resources :projects do
    resources :instruments do
      resources :versions, only: [:index, :show]
      resources :instrument_translations
      resources :sections 
      member do
        get :export
        get :export_responses
      end
    end
    member do 
      get :export
    end

    resources :responses
    resources :surveys
    resources :notifications, only: [:index]
    resources :devices, only: [:index]
    resources :response_images, only:[:show]
    resources :graphs, only:[:index]
    resources :response_exports  do
      member do
        get :download_project_responses  
        get :download_instrument_responses
        get :download_project_response_images
        get :download_instrument_response_images
        get :download_spss_syntax_file 
        get :download_instrument_spss_csv
        get :download_value_labels_csv
      end
    end
    get 'graphs/daily/' => 'graphs#daily_responses'
    get 'graphs/hourly/' => 'graphs#hourly_responses'
  end
  resources :request_roles, only: [:index]
  get "/photos/:id/:style.:format", :controller => "api/v1/frontend/images", :action => "show"
  get "/pictures/:id/:style.:format", :controller => "response_images", :action => "show"
  
end

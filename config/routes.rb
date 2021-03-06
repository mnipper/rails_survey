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
              resources :question_translations, only: [:update]
              member do
                post :copy
              end
              resources :options do
                resources :skips
                resources :option_translations, only: [:update]
              end
              resources :images
            end
            resources :sections do
              resources :section_translations, only: [:update]
            end
            resources :grids do
              resources :grid_labels
            end
          end
          get 'graphs/daily/' => 'graphs#daily'
          get 'graphs/hourly/' => 'graphs#hourly'
          get 'graphs/count/' => 'graphs#count'
        end
      end

      resources :projects do
        resources :instruments, only: [:index, :show]
        resources :device_users, only: [:index, :show]
        resources :questions, only: [:index, :show]
        resources :options, only: [:index, :show]
        resources :images, only: [:index, :show]
        resources :surveys, only: [:create]
        resources :responses, only: [:create]
        resources :response_images, only: [:create]
        resources :sections, only: [:index, :show]
        resources :android_updates, only: [:index, :show]
        resources :skips, only: [:index, :show]
        resources :rules, only: [:index]
        resources :device_sync_entries, only: [:create]
        resources :grids, only: [:index]
        resources :grid_labels, only: [:index]
      end
    end
  end

  root to: 'projects#index'
  resources :projects do
    resources :instruments do
      resources :versions, only: [:index, :show]
      resources :instrument_translations
      resources :sections
      resources :grids
      member do
        get :export
        get :export_responses
        get :move
        match :update_move, action: :update_move, via: [:patch, :put]
      end
    end
    
    member do
      get :export
    end

    resources :rules
    resources :device_users
    resources :responses
    concern :paginatable do
      get '(page/:page)', :action => :index, :on => :collection, :as => ''
    end
    resources :surveys, :concerns => :paginatable
    resources :notifications, only: [:index]
    resources :devices, only: [:index] do
      resources :device_sync_entries, only: [:index]
    end
    resources :response_images, only:[:show]
    resources :graphs, only:[:index]
    resources :response_exports  do
      member do
        get :project_long_format_responses
        get :project_wide_format_responses
        get :instrument_long_format_responses
        get :instrument_wide_format_responses
        get :project_response_images
        get :instrument_response_images
      end
    end
    get 'graphs/daily/' => 'graphs#daily_responses'
    get 'graphs/hourly/' => 'graphs#hourly_responses'
  end
  resources :request_roles, only: [:index]
  get "/photos/:id/:style.:format", :controller => "api/v1/frontend/images", :action => "show"
  get "/pictures/:id/:style.:format", :controller => "response_images", :action => "show"

end

RailsSurvey::Application.routes.draw do

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
      end
    end
  end

  root to: 'projects#index'
  resources :projects do
    resources :instruments do
      resources :versions, only: [:index, :show]
      resources :instrument_translations
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
    get 'graphs/daily/' => 'graphs#daily_responses'
    get 'graphs/hourly/' => 'graphs#hourly_responses'
  end

end

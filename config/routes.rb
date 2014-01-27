RailsSurvey::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :projects do
        resources :instruments, only: [:index, :show] do
          resources :questions do
            resources :options
          end
        end

        resources :questions, only: [:index, :show]
        resources :options, only: [:index, :show]
        resources :surveys, only: [:create]
        resources :responses, only: [:create]
      end
    end
  end

  root to: 'projects#index'
  resources :projects do
    resources :instruments do
      resources :versions, only: [:index, :show]
      resources :instrument_translations
      member { post :mercury_update }
    end

    resources :responses
    resources :surveys
    resources :notifications, only: [:index]
    resources :devices, only: [:index]
  end

  get '/realtime' => 'graphs#real_time'
  get '/graphs/update' => 'graphs#update'
  get '/bars' => 'graphs#bars'
  get '/lines' => 'graphs#hourly'
  get '/daily' => 'graphs#daily_responses'

  resources :graphs

end

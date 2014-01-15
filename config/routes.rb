RailsSurvey::Application.routes.draw do

  resources :projects

  devise_for :users
  resources :responses

  resources :surveys

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :instruments, only: [:index, :show] do
        resources :questions do
          resources :options
        end
      end
      resources :questions, only: [:index, :show]
      resources :options, only: [:index, :show]
      resources :surveys, only: [:create]
      resources :responses, only: [:create]
      resources :projects, only: [:index, :show]
    end
  end

  root to: 'instruments#index'
  resources :instruments do
    resources :versions, only: [:index, :show]
    resources :instrument_translations
  end
  resources :notifications, only: [:index]
  resources :devices, only: [:index]

  get '/realtime' => 'graphs#real_time'
  get '/graphs/update' => 'graphs#update'
  get '/bars' => 'graphs#bars'
  get '/lines' => 'graphs#hourly'
  get '/daily' => 'graphs#daily_responses'

  resources :graphs

end

RailsSurvey::Application.routes.draw do
  root to: 'instruments#index'
  resources :instruments
end

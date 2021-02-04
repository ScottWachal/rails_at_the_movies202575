Rails.application.routes.draw do
  resources :movies, only: %i[index show]
  resources :production_companies, only: %i[index show]
end

Rails.application.routes.draw do
  root to: redirect('/movies')
  get 'movies_add_to_favorites/:id', to: 'movies#addToFavorites', as: 'add_to_favorites'
  get 'movies_remove_from_favorites/:id', to: 'movies#removeFromFavorites', as: 'remove_from_favorites'
  get 'recomendations', to: 'movies#recomendations', as: 'recomendations'
  resources :movies
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

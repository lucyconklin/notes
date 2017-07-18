Rails.application.routes.draw do
  root to: 'notes#index'

  resources :notes, only: [:index, :new, :create]

  get '*path' => redirect('/')
end

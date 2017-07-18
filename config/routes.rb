Rails.application.routes.draw do
  root to: 'notes#index'

  resources :notes

  get '*path' => redirect('/')
end

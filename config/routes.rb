Rails.application.routes.draw do
  devise_for :users, :controllers => {
      registrations: 'registrations'
  }
  get 'tasks/index'
  root 'main_pages#index'
  get 'main_pages/index'
  resources :tasks
  resources :categories
  resources :tags
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

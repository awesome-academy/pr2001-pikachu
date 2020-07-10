# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get 'sessions/new'
  get 'users/new'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :categories, except: :show do
      resources :tours
    end

    resources :tour_details, except: %i[index show]
    resources :users, only: %i[index destroy]

    resources :tours, only: [] do
      resources :images, only: %i[new index create destroy]
    end
  end

  namespace :export_csv do
    resources :tours, only: :create
  end

  namespace :search do
    resources :tours, only: :index
  end

  resources :categories, only: [] do
    resources :tours, only: %i[index show]
  end
end

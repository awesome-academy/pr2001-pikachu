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
  get '/admin', to: 'admin/static_pages#home_admin'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :categories, except: :show do
      resources :tours
    end

    resources :tour_details, except: %i[index show]
    resources :users, only: %i[index destroy]
    resources :payments, only: :index
    resources :booking_tours, only: :index

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

  resources :tours, only: [] do
    resources :booking_tours, only: %i[new show create update]
    resources :ratings, only: [:create]
  end

  resources :tours do
    resources :reviews, only: %i[create destroy]
  end

  resources :comments, only: %i[create destroy] do
    resources :likes, only: [:create, :destroy]
  end
  resources :reviews, only: [] do
    resources :likes, only: [:create, :destroy]
  end
end

Rails.application.routes.draw do
  get 'groups/show'
  get 'groups/edit'
  get 'groups/new'
  get 'groups/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # 3.deviseが最初に来てない
  devise_for :users
  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create,:destroy]
    resources :book_comments, only: [:create,:destroy]
  end

  resources :users, only: [:index,:show,:edit,:update]
  resources :groups, except: [:destroy]
  # group離脱機能
  resources :groups do
    get "join" => "groups#join"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

# 1.endがない
end

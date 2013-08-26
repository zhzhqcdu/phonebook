  # -*- coding: utf-8 -*-
EPBook::Application.routes.draw do
  root :to => 'public#index'

  # 验证码
  captcha_route

  # public
  resources :products, :only => [:index]
  resources :clouds, :only => [:index]
  resources :downloads, :only => [:index]
  resources :news, :only => [:index]
  resources :helps, :only => [:index]
  resources :purchases, :only => [:index]

  # devise
  begin
    devise_for :users, :controllers => {
      :registrations => "users/registrations",
      :sessions => "users/sessions"
    }
  rescue Exception => e;end

  resources :dashboards, :only => [:index]

  devise_scope :user do
    get "/users/login" => "users/sessions#login"
    get "/users/logout" => "users/sessions#logout"
  end


  resources :users do
    get 'resend_email_confirmation', :on => :collection
    member do
      get 'adjust'
      put 'adjust_post'
    end
  end

  resources :organs, :except => [:destroy] do
    member do
      get 'remove_member'
    end
    collection do
      get 'new_member'
      post 'create_member'
      get 'search'
    end
  end

  resources :memberships, :except => [:show]

  resources :user_applies, :only => [:index, :new, :create, :update] do
    collection do
      get 'children_organs'
      get 'memberships'
    end
  end
  resources :organ_applies, :except => [:show] do
    member do
      get 'check'
    end
  end

  # Master routes
  namespace :master do
    root :to => 'home#index'
    resources :organs, :only => [:index, :update]
    resources :systems, :only => [:index]
  end

  mount API => 'api'
end

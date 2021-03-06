# -*- coding: utf-8 -*-
Phonebook::Application.routes.draw do
  # 设置用户登陆前后不同的 root  
  root :to => 'publics#index', :constraints => ->(request) do
    User.find_by_authentication_token(request.cookies["remember"]) or User.find_by_id(request.session[:user_id])
  end
  root :to => 'publics#login'

  resources :publics do
    collection do
      post 'authenticate'
      get 'logout'

      get "search"
    end
  end

  resources :organs

  resources :users, :except => [:index] do
    member do
      # 管理员操作
      get "reset"
      post "reset_submit"
      
      # 个人操作
      get "change"
      post "data_submit"
      post "password_submit"      
    end
  end

  resources :jobs, :except => [:show]
  resources :addresses, :except => [:show]

  resources :systems

  resources :properties, :only => [:index, :create, :edit]
end

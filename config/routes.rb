EPBook::Application.routes.draw do

  resources :users,:only=>[:new,:create]

  resources :phonebooks
  resources :ranks
  resources :organs
  resources :memberships
  resources :users
  root :to => 'default#index'
  resources :dashboard,:only=>[:index]
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

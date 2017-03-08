Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :projects do
    get :get_role_users, :on => :collection
  end
  resources :users
end

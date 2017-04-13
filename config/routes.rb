Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
get('/about', { to: 'about#index' })
get('/contacts', { to: 'contact#new'})

resources :posts do
  resources :comments, only: [:create, :destroy, :update]
end
resources :users, only: [:new, :create, :update, :edit]
resources :sessions, only: [:new, :create]
resources :sessions, only:[:new, :create] do
     delete :destroy, on: :collection
     #password does not show in the address url
   end
root 'welcome#index'
end

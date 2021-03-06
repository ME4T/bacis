Khoa::Application.routes.draw do
  
  resources :event_activities
  resources :event_types

  ActiveAdmin.routes(self)

    namespace :mercury do
      resources :images
    end


  devise_for :users, :controllers => { :registrations => :registrations }
  devise_for :users do get '/users/sign_out' => 'devise/sessions#destroy' end
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  match '/auth/:provider/callback' => 'authentications#create'

  mount Mercury::Engine => '/'

  match "transactions/:action", :controller => 'transactions', :action => /[a-z]+/i
  resources :authentications
  resources :transactions
  resources :friends
  resources :posts
  resources :mails
  resources :events




  get "users/username_exists"
  get "users/email_exists"
  resources :users



  mount Mercury::Engine => '/'

  resources :events do
    member { put :mercury_update }
    end



  root to: 'static_pages#home' 
  
  
  match '/myevents', to: 'events#myevent'
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/terms',   to: 'static_pages#terms'
  match '/report',   to: 'static_pages#report'
  match '/contact', to: 'static_pages#contact'
  match '/contact_ajax', to: 'static_pages#contact_ajax'
  match '/listevents', to: 'events#list'
  match '/calevents', to: 'events#cal'
  

  post "static_pages/contact_ajax"
  post "static_pages/report"
  get "static_pages/home"
  get "static_pages/about"
  get "static_pages/help"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

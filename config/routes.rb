Agora::Application.routes.draw do
  get "sessions/create" => "sessions#create", :as => :create_session
  get "sessions/destroy" => "sessions#destroy", :as => :destroy_session

  get "categories/search" => "categories#search", :as => :search_categories

  get "users/edit" => "users#edit", :as => :edit_user
  get "users/get_reset_key" => "users#get_reset_key", :as => :get_reset_key
  post "users/send_reset_key" => "users#send_reset_key", :as => :send_reset_key
  get "users/reset_password/:id/:reset_key" => "users#reset_password", :as => :reset_password

  get "topics/new/:category_id" => "topics#new", :as => :new_topic

  get "categories/:id/subscribe" => "categories#subscribe", :as => :subscribe_category
  get "categories/:id/unsubscribe" => "categories#unsubscribe", :as => :unsubscribe_category

  post "comments/:id/reply" => "comments#reply", :as => :reply_comment
  get "comments/:id/delete" => "comments#delete", :as => :delete_comment

  post "topics/vote/:id/:positive" => "topics#vote", :as => :vote_topic
  post "comments/vote/:id/:positive" => "comments#vote", :as => :vote_comment

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

  resources :users
  resources :categories
  resources :topics
  resources :comments

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
  root :to => 'categories#show'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id))(.:format)'
end

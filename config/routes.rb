Store::Application.routes.draw do

  scope "(:locale)", locale: /en|hr/ do

    resources :line_items
    resources :carts, :except => [:show]
    resources :orders, :except => [:index, :destroy]

    root :to => 'pages#home'
    match 'products/:id' => 'variants#show', :as => :product
    match 'products' => 'pages#home'
    match 'cart' => 'carts#show', :as => :show_cart

    devise_for :users

    namespace :admin do
      match '/' => 'products#index', :as => :root
      resources :products do
        resources :variants do
          resources :images#, :only => [:index, :new, :create]
        end
        resources :images#, :only => [:index, :new, :create]
        resources :taxonomies, :controller => 'product_taxonomies'
      end
      resources :orders
      resources :taxonomies
      resources :option_types
      #resources :images, :only => [:destroy]
    end
  end

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

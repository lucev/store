Store::Application.routes.draw do

  scope "(:locale)", locale: /en|hr/ do

    root :to => 'pages#home'
    match 'products/:id' => 'variants#show', :as => :product
    match 'products' => 'pages#home'
    match 'cart' => 'carts#show', :as => :show_cart

    # payments
    match '/authorize_net_callback' => 'payments#authorize_net_callback', :as => 'authorize_net_callback'
    match '/paypal_callback' => 'payments#paypal_callback', :as => 'paypal_callback'
    match '/payments/thank_you', :to => 'payments#thank_you', :as => 'payments_thank_you', :via => [:get]

    resources :line_items
    resources :carts, :except => [:show]
    resources :orders, :except => [:index, :destroy]
    devise_for :users

    namespace :admin do
      match '/' => 'products#index', :as => :root
      post '/option_types/:option_type_id/option_values' => 'option_types#create_value', :as => :option_values
      delete '/option_types/:option_type_id/option_values/:id' => 'option_types#destroy_value', :as => :option_value

      resources :products do
        resources :variants do
          resources :images#, :only => [:index, :new, :create]
          resources :option_values, :controller => 'variant_option_values'
        end
        resources :images#, :only => [:index, :new, :create]
        resources :taxonomies, :controller => 'product_taxonomies'
        resources :option_types, :controller => 'product_option_types'
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
